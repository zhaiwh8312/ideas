package com.sfbm.ideas.services.front.idea.dao.impl;

import com.sfbm.ideas.core.dao.BaseDAO;
import com.sfbm.ideas.services.common.IdeaInfo;
import com.sfbm.ideas.services.front.idea.dao.IdeaInfoDAO;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
@Repository(value = "ideaInfoDAO")
public class IdeaInfoDAOImpl extends BaseDAO implements IdeaInfoDAO {
    @Override
    public void insertIdeaInfo(IdeaInfo ideaInfo) throws Exception {
        getSqlSession().insert("IdeaInfo.insertIdeaInfo", ideaInfo);
    }

    @Override
    public void updateIdeaInfo(IdeaInfo ideaInfo) throws Exception {
        getSqlSession().update("IdeaInfo.updateIdeaInfo", ideaInfo);
    }

    @Override
    public IdeaInfo queryIdeaInfoByIdeaId(long ideaId) throws Exception {
        return getSqlSession().selectOne("IdeaInfo.queryIdeaInfoByIdeaId", ideaId);
    }

    @Override
    public List<IdeaInfo> queryIdeaInfoListByUserId(long userId) throws Exception {
        return getSqlSession().selectList("IdeaInfo.queryIdeaInfoListByUserId", userId);
    }

    @Override
    public List<IdeaInfo> queryIdeaInfoList() throws Exception {
        return getSqlSession().selectList("IdeaInfo.queryIdeaInfoList");
    }

    @Override
    public List<IdeaInfo> queryIdeaInfoListIsPublic() throws Exception {
        return getSqlSession().selectList("IdeaInfo.queryIdeaInfoListIsPublic");
    }
}
