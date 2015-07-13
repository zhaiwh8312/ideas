package com.sfbm.ideas.services.front.idea.dao.impl;

import com.sfbm.ideas.core.dao.BaseDAO;
import com.sfbm.ideas.services.common.IdeaNodeInfo;
import com.sfbm.ideas.services.front.idea.dao.IdeaNodeInfoDAO;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
@Repository(value = "ideaNodeInfoDAO")
public class IdeaNodeInfoDAOImpl extends BaseDAO implements IdeaNodeInfoDAO {
    @Override
    public void insertIdeaNodeInfo(IdeaNodeInfo ideaNodeInfo) throws Exception {
        getSqlSession().insert("IdeaNodeInfo.insertIdeaNodeInfo", ideaNodeInfo);
    }

    @Override
    public void updateIdeaNodeInfo(IdeaNodeInfo ideaNodeInfo) throws Exception {
        getSqlSession().update("IdeaNodeInfo.updateIdeaNodeInfo", ideaNodeInfo);
    }

    @Override
    public IdeaNodeInfo queryIdeaNodeInfoByNodeId(long nodeId) throws Exception {
        return getSqlSession().selectOne("IdeaNodeInfo.queryIdeaNodeInfoByNodeId", nodeId);
    }

    @Override
    public List<IdeaNodeInfo> queryIdeaNodeInfoByIdeaId(long ideaId) throws Exception {
        return getSqlSession().selectList("IdeaNodeInfo.queryIdeaNodeInfoByIdeaId", ideaId);
    }
}
