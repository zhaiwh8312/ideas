package com.sfbm.ideas.services.front.user.impl;

import com.sfbm.ideas.core.util.Encryption;
import com.sfbm.ideas.core.util.MD5;
import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.core.constant.UserStatus;
import com.sfbm.ideas.services.front.user.UserRegistService;
import com.sfbm.ideas.services.dao.UserCoreInfoDAO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
@Service(value = "userRegistService")
public class UserRegistServiceImpl implements UserRegistService {
    @Resource
    private UserCoreInfoDAO userCoreInfoDAO;

    @Override
    public UserCoreInfo regist(String email, String password) throws Exception {
        if (null == email || "".equals(email.trim())) {
            return null;
        }

        UserCoreInfo userCoreInfo = new UserCoreInfo();

        userCoreInfo.setEmail(email);
        userCoreInfo.setPassword(new MD5().getMD5ofStr(Encryption.SHA1(password)));
        userCoreInfo.setCreateTime(new Date());
        userCoreInfo.setStatus(UserStatus.ACTIVE.getName());

        userCoreInfoDAO.insertUserCoreInfo(userCoreInfo);

        return userCoreInfo;
    }
}
