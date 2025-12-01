--[[
    Azeroth Pilot Reloaded - Smart Quest Orderer
    Intelligent quest ordering based on location, level, and dependencies
    
    @author APR Development Team
    @version 5.0.0
]]

local ADDON_NAME = "APR"

-- Create namespace
APR = APR or {}
APR.Quest = APR.Quest or {}
APR.Quest.Orderer = {}

-- Local references
local format = string.format
local tinsert = table.insert
local sort = table.sort
local sqrt = math.sqrt
local abs = math.abs

-----------------------------------------------------------
-- Quest Ordering Configuration
-----------------------------------------------------------

local OrderConfig = {
    -- Weights for ordering algorithm
    weights = {
        distance = 0.4,      -- 40% weight on distance
        level = 0.2,         -- 20% weight on level
        priority = 0.2,      -- 20% weight on priority
        dependency = 0.2,    -- 20% weight on dependencies
    },
    
    -- Distance calculation
    maxDistance = 1000,      -- Maximum distance for normalization
    
    -- Level calculation
    levelDiffPenalty = 5,    -- Penalty per level difference
    
    -- Optimization
    enableCaching = true,
    recalculateInterval = 5, -- seconds
}

-----------------------------------------------------------
-- Quest Orderer Core
-----------------------------------------------------------

local QuestOrderer = {
    -- Ordered quest list
    orderedQuests = {},
    
    -- Quest priorities
    priorities = {},
    
    -- Quest dependencies
    dependencies = {},
    
    -- Quest locations
    locations = {},
    
    -- Cache
    orderCache = nil,
    cacheTimestamp = 0,
}

-----------------------------------------------------------
-- Quest Ordering
-----------------------------------------------------------

-- Order quests
function QuestOrderer:OrderQuests(questIDs, playerPos)
    -- Check cache
    if OrderConfig.enableCaching and self.orderCache then
        local now = GetTime()
        if now - self.cacheTimestamp < OrderConfig.recalculateInterval then
            return self.orderCache
        end
    end
    
    APR.Logger:Debug("QuestOrderer", format("Ordering %d quests", #questIDs))
    
    -- Calculate scores for each quest
    local questScores = {}
    
    for _, questID in ipairs(questIDs) do
        local score = self:CalculateQuestScore(questID, playerPos)
        tinsert(questScores, {
            questID = questID,
            score = score,
        })
    end
    
    -- Sort by score (lower is better)
    sort(questScores, function(a, b)
        return a.score < b.score
    end)
    
    -- Extract ordered quest IDs
    local ordered = {}
    for _, entry in ipairs(questScores) do
        tinsert(ordered, entry.questID)
    end
    
    -- Cache result
    if OrderConfig.enableCaching then
        self.orderCache = ordered
        self.cacheTimestamp = GetTime()
    end
    
    APR.Logger:Debug("QuestOrderer", format("Quest ordering complete: %d quests", #ordered))
    
    return ordered
end

-- Calculate quest score
function QuestOrderer:CalculateQuestScore(questID, playerPos)
    local score = 0
    
    -- Distance score
    local distanceScore = self:CalculateDistanceScore(questID, playerPos)
    score = score + (distanceScore * OrderConfig.weights.distance)
    
    -- Level score
    local levelScore = self:CalculateLevelScore(questID)
    score = score + (levelScore * OrderConfig.weights.level)
    
    -- Priority score
    local priorityScore = self:CalculatePriorityScore(questID)
    score = score + (priorityScore * OrderConfig.weights.priority)
    
    -- Dependency score
    local dependencyScore = self:CalculateDependencyScore(questID)
    score = score + (dependencyScore * OrderConfig.weights.dependency)
    
    return score
end

-----------------------------------------------------------
-- Score Calculations
-----------------------------------------------------------

-- Calculate distance score
function QuestOrderer:CalculateDistanceScore(questID, playerPos)
    local questPos = self.locations[questID]
    
    if not questPos or not playerPos then
        return 0.5 -- Neutral score if no position data
    end
    
    local distance = self:CalculateDistance(playerPos, questPos)
    
    -- Normalize distance (0 = closest, 1 = farthest)
    local normalized = distance / OrderConfig.maxDistance
    normalized = math.min(normalized, 1.0)
    
    return normalized
end

-- Calculate level score
function QuestOrderer:CalculateLevelScore(questID)
    local questLevel = C_QuestLog.GetQuestDifficultyLevel(questID)
    local playerLevel = UnitLevel("player")
    
    if not questLevel then
        return 0.5 -- Neutral score if no level data
    end
    
    local levelDiff = abs(questLevel - playerLevel)
    
    -- Penalty for level difference
    local penalty = levelDiff * OrderConfig.levelDiffPenalty
    
    -- Normalize (0 = perfect level, 1 = very different level)
    local normalized = penalty / 100
    normalized = math.min(normalized, 1.0)
    
    return normalized
end

-- Calculate priority score
function QuestOrderer:CalculatePriorityScore(questID)
    local priority = self.priorities[questID] or 50
    
    -- Normalize priority (0 = highest priority, 1 = lowest priority)
    local normalized = (100 - priority) / 100
    
    return normalized
end

-- Calculate dependency score
function QuestOrderer:CalculateDependencyScore(questID)
    local deps = self.dependencies[questID]
    
    if not deps or #deps == 0 then
        return 0 -- No dependencies = can do immediately
    end
    
    -- Check if dependencies are complete
    local completedDeps = 0
    for _, depID in ipairs(deps) do
        if C_QuestLog.IsQuestFlaggedCompleted(depID) then
            completedDeps = completedDeps + 1
        end
    end
    
    -- Normalize (0 = all deps complete, 1 = no deps complete)
    local normalized = 1 - (completedDeps / #deps)
    
    return normalized
end

-----------------------------------------------------------
-- Distance Calculation
-----------------------------------------------------------

-- Calculate distance between two points
function QuestOrderer:CalculateDistance(pos1, pos2)
    local dx = pos2.x - pos1.x
    local dy = pos2.y - pos1.y
    
    return sqrt(dx * dx + dy * dy)
end

-----------------------------------------------------------
-- Quest Data Management
-----------------------------------------------------------

-- Set quest priority
function QuestOrderer:SetPriority(questID, priority)
    self.priorities[questID] = priority
    self:InvalidateCache()
    
    APR.Logger:Debug("QuestOrderer", format("Quest %d priority set to %d", questID, priority))
end

-- Set quest dependencies
function QuestOrderer:SetDependencies(questID, dependencies)
    self.dependencies[questID] = dependencies
    self:InvalidateCache()
    
    APR.Logger:Debug("QuestOrderer", format("Quest %d dependencies set: %d", questID, #dependencies))
end

-- Set quest location
function QuestOrderer:SetLocation(questID, x, y)
    self.locations[questID] = {x = x, y = y}
    self:InvalidateCache()
    
    APR.Logger:Debug("QuestOrderer", format("Quest %d location set: %.2f, %.2f", questID, x, y))
end

-- Get quest location
function QuestOrderer:GetLocation(questID)
    return self.locations[questID]
end

-----------------------------------------------------------
-- Route Optimization
-----------------------------------------------------------

-- Optimize quest route (traveling salesman problem approximation)
function QuestOrderer:OptimizeRoute(questIDs, startPos)
    if #questIDs <= 1 then
        return questIDs
    end
    
    APR.Logger:Debug("QuestOrderer", format("Optimizing route for %d quests", #questIDs))
    
    local route = {}
    local remaining = {}
    
    -- Copy quest IDs to remaining
    for _, questID in ipairs(questIDs) do
        tinsert(remaining, questID)
    end
    
    local currentPos = startPos
    
    -- Greedy nearest neighbor algorithm
    while #remaining > 0 do
        local nearestIdx = 1
        local nearestDist = math.huge
        
        -- Find nearest quest
        for i, questID in ipairs(remaining) do
            local questPos = self.locations[questID]
            
            if questPos then
                local dist = self:CalculateDistance(currentPos, questPos)
                
                if dist < nearestDist then
                    nearestDist = dist
                    nearestIdx = i
                end
            end
        end
        
        -- Add nearest quest to route
        local nearestQuest = table.remove(remaining, nearestIdx)
        tinsert(route, nearestQuest)
        
        -- Update current position
        local questPos = self.locations[nearestQuest]
        if questPos then
            currentPos = questPos
        end
    end
    
    APR.Logger:Debug("QuestOrderer", format("Route optimization complete: %d quests", #route))
    
    return route
end

-----------------------------------------------------------
-- Quest Grouping
-----------------------------------------------------------

-- Group quests by zone
function QuestOrderer:GroupByZone(questIDs)
    local groups = {}
    
    for _, questID in ipairs(questIDs) do
        local zoneID = self:GetQuestZone(questID)
        
        if not groups[zoneID] then
            groups[zoneID] = {}
        end
        
        tinsert(groups[zoneID], questID)
    end
    
    return groups
end

-- Group quests by level
function QuestOrderer:GroupByLevel(questIDs, levelRange)
    levelRange = levelRange or 5
    
    local groups = {}
    
    for _, questID in ipairs(questIDs) do
        local level = C_QuestLog.GetQuestDifficultyLevel(questID) or 0
        local groupKey = math.floor(level / levelRange) * levelRange
        
        if not groups[groupKey] then
            groups[groupKey] = {}
        end
        
        tinsert(groups[groupKey], questID)
    end
    
    return groups
end

-- Get quest zone
function QuestOrderer:GetQuestZone(questID)
    -- This would need to be implemented based on quest location
    -- For now, return a placeholder
    return 0
end

-----------------------------------------------------------
-- Cache Management
-----------------------------------------------------------

-- Invalidate cache
function QuestOrderer:InvalidateCache()
    self.orderCache = nil
    self.cacheTimestamp = 0
end

-- Clear all data
function QuestOrderer:Clear()
    self.orderedQuests = {}
    self.priorities = {}
    self.dependencies = {}
    self.locations = {}
    self:InvalidateCache()
end

-----------------------------------------------------------
-- Initialization
-----------------------------------------------------------

function QuestOrderer:Initialize()
    APR.Logger:Info("QuestOrderer", "Initializing Quest Orderer")
    
    -- Register for events
    if APR.EventBus then
        APR.EventBus:On("QUEST_ACCEPTED", function(questID)
            self:InvalidateCache()
        end)
        
        APR.EventBus:On("QUEST_COMPLETED", function(questID)
            self:InvalidateCache()
        end)
        
        APR.EventBus:On("PLAYER_POSITION_CHANGED", function(pos)
            self:InvalidateCache()
        end)
    end
    
    APR.Logger:Info("QuestOrderer", "Quest Orderer initialized")
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

APR.Quest.Orderer = QuestOrderer

-- Convenience functions
function APR:OrderQuests(questIDs, playerPos)
    return QuestOrderer:OrderQuests(questIDs, playerPos)
end

function APR:OptimizeQuestRoute(questIDs, startPos)
    return QuestOrderer:OptimizeRoute(questIDs, startPos)
end

function APR:SetQuestPriority(questID, priority)
    return QuestOrderer:SetPriority(questID, priority)
end

-- Initialize on module load
if APR.ModuleManager then
    APR:RegisterModule("QuestOrderer", {
        version = "5.0.0",
        priority = 32,
        dependencies = {"EventBus", "Logger"},
        init = function()
            QuestOrderer:Initialize()
        end,
    })
end

return APR.Quest.Orderer