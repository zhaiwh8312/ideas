package com.sfbm.ideas.services.front.user.impl;

import com.sfbm.ideas.services.front.user.UserCheckUniqueService;
import com.sfbm.ideas.services.dao.UserCoreInfoDAO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
@Service(value = "userCheckUniqueService")
public class UserCheckUniqueServiceImpl implements UserCheckUniqueService {
    @Resource
    private UserCoreInfoDAO userCoreInfoDAO;

    @Override
    public boolean checkUserIsUniqueByEmail(String email) throws Exception {
        if (null == email || "".equals(email)) {
            return false;
        }

        int count = userCoreInfoDAO.queryCountUserCoreInfoByEmail(email);

        if (count > 0) {
            return false;
        } else {
            return true;
        }
    }
}
