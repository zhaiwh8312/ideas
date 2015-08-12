package com.sfbm.ideas.web.controller;

import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.services.front.user.UserCheckUniqueService;
import com.sfbm.ideas.services.front.user.UserRegistService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
@Controller
@Scope("request")
public class RegistController {
    @Resource
    private UserCheckUniqueService userCheckUniqueService;
    @Resource
    private UserRegistService userRegistService;

    @RequestMapping(value="/user/checkEmailUnique.json", method = RequestMethod.POST)
    public @ResponseBody boolean doCheckUnique(@RequestParam(required = true) String email) {
        boolean flag = false;

        try {
            flag = userCheckUniqueService.checkUserIsUniqueByEmail(email);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    @RequestMapping(value="/user/regist.json", method = RequestMethod.POST)
    public @ResponseBody boolean doRegist(@RequestParam(required = true) String email, @RequestParam(required = true) String password) {
        UserCoreInfo userCoreInfo = null;

        try {
            userCoreInfo = userRegistService.regist(email, password);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (null == userCoreInfo || 0 == userCoreInfo.getUserId()) {
            // 注册失败

            return false;
        } else {
            // 注册成功

            return true;
        }
    }
}
