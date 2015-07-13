package com.sfbm.ideas.services.front.idea.dao;

import com.sfbm.ideas.services.common.IdeaNodeInfo;

import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
public interface IdeaNodeInfoDAO {

    public void insertIdeaNodeInfo(IdeaNodeInfo ideaNodeInfo) throws Exception;

    public void updateIdeaNodeInfo(IdeaNodeInfo ideaNodeInfo) throws Exception;

    public IdeaNodeInfo queryIdeaNodeInfoByNodeId(long nodeId) throws Exception;

    public List<IdeaNodeInfo> queryIdeaNodeInfoByIdeaId(long ideaId) throws Exception;

}
