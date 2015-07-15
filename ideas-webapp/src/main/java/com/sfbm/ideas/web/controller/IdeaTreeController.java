package com.sfbm.ideas.web.controller;

import com.sfbm.ideas.services.common.IdeaInfo;
import com.sfbm.ideas.services.common.IdeaNodeInfo;
import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.services.constant.SessionKey;
import com.sfbm.ideas.services.front.idea.IdeaService;
import com.sfbm.ideas.services.front.idea.IdeaTreeService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/14.
 */
@Controller
@Scope("prototype")
public class IdeaTreeController {
    @Resource
    private IdeaService ideaService;
    @Resource
    private IdeaTreeService ideaTreeService;

    @RequestMapping(value="/idea/{ideaId}.html")
    public ModelAndView doShowIdeaDetail(HttpSession session, @PathVariable long ideaId) {
        ModelAndView mav = new ModelAndView();

        try {
            IdeaInfo ideaInfo = ideaService.getIdeaInfo(ideaId);

            UserCoreInfo userCoreInfo = (UserCoreInfo)session.getAttribute(SessionKey.USER);

            if (null == ideaInfo) {
                mav.setViewName("redirect:/index.html");
            } else if (!ideaInfo.getIsPublic() && null == userCoreInfo) {
                mav.setViewName("redirect:/index.html");
            } else if (!ideaInfo.getIsPublic() && userCoreInfo.getUserId() != ideaInfo.getUserId()) {
                mav.setViewName("redirect:/index.html");
            } else {
                List<IdeaNodeInfo> nodeInfoList = ideaTreeService.getIdeaTreeByIdeaId(ideaId);

                mav.addObject("ideaInfo", ideaInfo);
                mav.addObject("nodeInfoList", nodeInfoList);
                mav.setViewName("views/ideas/tree/index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return mav;
    }

    @RequestMapping(value="/idea_node/add.json", method = RequestMethod.POST)
    public @ResponseBody IdeaNodeInfo doAddNode(HttpSession session,
                                                @RequestParam(required = true) String nodeContent,
                                                @RequestParam(required = true) long ideaId,
                                                @RequestParam(required = true) long parentId,
                                                @RequestParam(required = true) int xLocation,
                                                @RequestParam(required = true) int yLocation) {
        IdeaNodeInfo ideaNodeInfo = new IdeaNodeInfo();

        UserCoreInfo userCoreInfo = (UserCoreInfo)session.getAttribute(SessionKey.USER);

        try {
            ideaNodeInfo = ideaTreeService.saveIdeaNodeInfo(userCoreInfo.getUserId(), ideaId, parentId, nodeContent, xLocation, yLocation);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ideaNodeInfo;
    }

    @RequestMapping(value="/idea_node/update_location.json", method = RequestMethod.POST)
    public @ResponseBody IdeaNodeInfo doUpdateNodeLocation(HttpSession session,
                                                           @RequestParam(required = true) long nodeId,
                                                           @RequestParam(required = true) int xLocation,
                                                           @RequestParam(required = true) int yLocation) {
        IdeaNodeInfo ideaNodeInfo = new IdeaNodeInfo();

        UserCoreInfo userCoreInfo = (UserCoreInfo)session.getAttribute(SessionKey.USER);

        try {
            ideaNodeInfo = ideaTreeService.modifyIdeaNodeInfoForLocation(userCoreInfo.getUserId(), nodeId, xLocation, yLocation);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ideaNodeInfo;
    }
}
