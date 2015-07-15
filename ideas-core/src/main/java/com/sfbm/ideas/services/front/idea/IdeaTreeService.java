package com.sfbm.ideas.services.front.idea;

import com.sfbm.ideas.services.common.IdeaNodeInfo;

import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/14.
 */
public interface IdeaTreeService {

    public IdeaNodeInfo saveIdeaNodeInfo(long userId, long ideaId, long parentId, String nodeContent, int xLocation, int yLocation) throws Exception;

    public List<IdeaNodeInfo> getIdeaTreeByIdeaId(long ideaId) throws Exception;

    public IdeaNodeInfo modifyIdeaNodeInfoForLocation(long userId, long nodeId, int xLocation, int yLocation) throws Exception;
}
