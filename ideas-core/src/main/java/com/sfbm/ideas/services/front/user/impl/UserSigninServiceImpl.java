package com.sfbm.ideas.services.front.user.impl;

import com.sfbm.ideas.core.util.Encryption;
import com.sfbm.ideas.core.util.MD5;
import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.services.front.user.UserSigninService;
import com.sfbm.ideas.services.dao.UserCoreInfoDAO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
@Service(value = "userSigninService")
public class UserSigninServiceImpl implements UserSigninService {
    @Resource
    private UserCoreInfoDAO userCoreInfoDAO;

    @Override
    public UserCoreInfo signin(String email, String password) throws Exception {
        if (null == email || "".equals(email.trim())) {
            return null;
        }

        UserCoreInfo userCoreInfo = userCoreInfoDAO.queryUserCoreInfoByEmail(email);

        if (null == userCoreInfo) {
            return null;
        } else if (userCoreInfo.getPassword().equalsIgnoreCase(new MD5().getMD5ofStr(Encryption.SHA1(password)))) {
            return userCoreInfo;
        } else {
            return null;
        }
    }
}
