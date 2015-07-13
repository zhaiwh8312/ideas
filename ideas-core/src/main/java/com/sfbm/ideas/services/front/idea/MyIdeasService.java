package com.sfbm.ideas.services.front.idea;

import com.sfbm.ideas.services.common.IdeaInfo;

import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
public interface MyIdeasService {

    public List<IdeaInfo> getMyIdeasList(long userId) throws Exception;
}
