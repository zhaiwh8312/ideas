package com.sfbm.ideas.services.front.test.impl;

import com.sfbm.ideas.core.constant.IdeaStatus;
import com.sfbm.ideas.core.constant.UserStatus;
import com.sfbm.ideas.services.common.IdeaInfo;
import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.services.dao.IdeaInfoDAO;
import com.sfbm.ideas.services.dao.UserCoreInfoDAO;
import com.sfbm.ideas.services.front.test.IDService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/08/10.
 */
@Service(value = "idService")
public class IDServiceImpl implements IDService {
    @Resource
    private UserCoreInfoDAO userCoreInfoDAO;
    @Resource
    private IdeaInfoDAO ideaInfoDAO;

    @Override
    public void addTest() throws Exception {
        UserCoreInfo userCoreInfo = new UserCoreInfo();

        userCoreInfo.setEmail("maverick_3940@163.com");
        userCoreInfo.setPassword("123");
        userCoreInfo.setCreateTime(new Date());
        userCoreInfo.setStatus(UserStatus.ACTIVE.getName());

        userCoreInfoDAO.insertUserCoreInfo(userCoreInfo);

        System.out.println("test id 此处有user_id才行 : " + userCoreInfo.getUserId());

        IdeaInfo ideaInfo = new IdeaInfo();

        ideaInfo.setIdeaName("test");
        ideaInfo.setUserId(userCoreInfo.getUserId());
        ideaInfo.setIsPublic(true);
        ideaInfo.setCreateTime(new Date());
        ideaInfo.setStatus(IdeaStatus.NORMAL.getName());

        ideaInfoDAO.insertIdeaInfo(ideaInfo);

        System.out.println("test id 此处有idea_id才行 : " + ideaInfo.getIdeaId());

        int a = 1 / 0;

//        throw new Exception("test");
    }
}
