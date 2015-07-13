package com.sfbm.ideas.services.front.idea.dao;

import com.sfbm.ideas.services.common.IdeaInfo;

import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
public interface IdeaInfoDAO {

    public void insertIdeaInfo(IdeaInfo ideaInfo) throws Exception;

    public void updateIdeaInfo(IdeaInfo ideaInfo) throws Exception;

    public IdeaInfo queryIdeaInfoByIdeaId(long ideaId) throws Exception;

    public List<IdeaInfo> queryIdeaInfoListByUserId(long userId) throws Exception;

    public List<IdeaInfo> queryIdeaInfoList() throws Exception;

    public List<IdeaInfo> queryIdeaInfoListIsPublic() throws Exception;

}
