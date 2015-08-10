package com.sfbm.ideas.services.front.idea.impl;

import com.sfbm.ideas.services.common.IdeaInfo;
import com.sfbm.ideas.services.front.idea.MyIdeasService;
import com.sfbm.ideas.services.dao.IdeaInfoDAO;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
@Service(value = "myIdeasService")
public class MyIdeasServiceImpl implements MyIdeasService {
    @Resource
    private IdeaInfoDAO ideaInfoDAO;

    @Override
    @Cacheable(value="myIdeas")
    public List<IdeaInfo> getMyIdeasList(long userId) throws Exception {
        List<IdeaInfo> ideaList = ideaInfoDAO.queryIdeaInfoListByUserId(userId);

        return ideaList;
    }
}
