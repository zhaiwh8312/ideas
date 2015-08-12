package com.sfbm.ideas.web.controller;

import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.core.constant.SessionKey;
import com.sfbm.ideas.services.front.user.UserSigninService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

/**
 * 登录
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
@Controller
@Scope("request")
public class SigninController {
    @Resource
    private UserSigninService userSigninService;

    @RequestMapping(value="/user/login.html")
    public ModelAndView doInit() {
        ModelAndView mav = new ModelAndView();

        mav.setViewName("views/user/signin/index.jsp");

        return mav;
    }

    @RequestMapping(value="/user/login.do", method = RequestMethod.POST)
    public ModelAndView doLogin(HttpSession session, @RequestParam(required = true) String email, @RequestParam(required = true) String password) {
        ModelAndView mav = new ModelAndView();

        UserCoreInfo userCoreInfo = null;

        try {
            userCoreInfo = userSigninService.signin(email, password);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (null == userCoreInfo) {
            mav.setViewName("redirect:/user/login.html");
        } else {
            session.setAttribute(SessionKey.USER, userCoreInfo);

            if (null != session.getAttribute(SessionKey.CLIENT_REQ_URL)) {
                String clientReqUrl = session.getAttribute(SessionKey.CLIENT_REQ_URL).toString();

                session.removeAttribute(SessionKey.CLIENT_REQ_URL);

                mav.setViewName("redirect:" + clientReqUrl);
            } else {
                mav.setViewName("redirect:/myideas/index.html");
            }
        }

        return mav;
    }

    @RequestMapping(value="/user/logout.do")
    public ModelAndView doLogout(HttpSession session) {
        ModelAndView mav = new ModelAndView();

        session.invalidate();

        mav.setViewName("redirect:/index.html");

        return mav;
    }


}
