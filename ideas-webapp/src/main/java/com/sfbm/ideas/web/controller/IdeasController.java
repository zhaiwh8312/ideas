package com.sfbm.ideas.web.controller;

import com.sfbm.ideas.services.common.IdeaInfo;
import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.services.constant.SessionKey;
import com.sfbm.ideas.services.front.idea.IdeaService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
@Controller
@Scope("prototype")
public class IdeasController {
    @Resource
    private IdeaService ideaService;

    @RequestMapping(value="/idea/add.json", method = RequestMethod.POST)
    public @ResponseBody long doAddIdea(HttpSession session, @RequestParam(required = true) String ideaName, String ideaPicUrl, boolean isPublic) {
        UserCoreInfo userCoreInfo = null;

        if (null != session.getAttribute(SessionKey.USER)) {
            userCoreInfo = (UserCoreInfo)session.getAttribute(SessionKey.USER);
        }

        IdeaInfo ideaInfo = null;

        try {
            ideaInfo = ideaService.saveIdeaInfo(userCoreInfo.getUserId(), ideaName, ideaPicUrl, isPublic);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (null == ideaInfo) {
            return -1;
        } else {
            return ideaInfo.getIdeaId();
        }
    }

    @RequestMapping(value="/idea/public_list.json", method = RequestMethod.POST)
    public @ResponseBody List<IdeaInfo> doGetIdeaList(int offset, int limit) {
        List<IdeaInfo> ideaInfoList = new ArrayList<IdeaInfo>();

        try {
            ideaInfoList = ideaService.getPublicIdeaInfoList(offset, limit);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ideaInfoList;
    }

}
