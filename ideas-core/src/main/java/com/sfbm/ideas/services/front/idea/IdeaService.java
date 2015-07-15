package com.sfbm.ideas.services.front.idea;

import com.sfbm.ideas.services.common.IdeaInfo;

import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
public interface IdeaService {

    public IdeaInfo getIdeaInfo(long ideaId) throws Exception;

    public IdeaInfo saveIdeaInfo(long userId, String ideaName, String ideaPicUrl, boolean isPublic) throws Exception;

    public List<IdeaInfo> getPublicIdeaInfoList(int offset, int limit) throws Exception;

}
