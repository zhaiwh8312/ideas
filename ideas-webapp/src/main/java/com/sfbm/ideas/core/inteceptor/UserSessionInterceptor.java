package com.sfbm.ideas.core.inteceptor;

import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.services.constant.SessionKey;
import com.sfbm.ideas.services.constant.URLSuffix;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/14.
 */
public class UserSessionInterceptor implements HandlerInterceptor {

    // Controller之前执行
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        HttpSession session = httpServletRequest.getSession();

        UserCoreInfo userCoreInfo = (UserCoreInfo)session.getAttribute(SessionKey.USER);

        if (null != userCoreInfo) {
            return true;
        } else {
            if (httpServletRequest.getRequestURI().indexOf(".") > 0) {
                if (httpServletRequest.getRequestURI().split("\\.")[1].toString().equals(URLSuffix.HTML)) {
                    session.setAttribute(SessionKey.CLIENT_REQ_URL, httpServletRequest.getRequestURI().replace(httpServletRequest.getContextPath(), ""));
                }
            }

            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/user/login.html");

            return false;
        }
    }

    // 生成视图之前执行
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    // 最后执行，可用于释放资源
    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
