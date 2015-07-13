package com.sfbm.ideas.services.front.idea;

import com.sfbm.ideas.services.common.IdeaInfo;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
public interface IdeaService {

    public IdeaInfo saveIdeaInfo(long userId, String ideaName, String ideaPicUrl, boolean isPublic) throws Exception;

}
