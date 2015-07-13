package com.sfbm.ideas.services.common;

import java.io.Serializable;
import java.util.Date;

/**
 * 点子主信息
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
public class IdeaInfo implements Serializable {
    private long ideaId;
    private long userId;
    private String ideaName;
    private String ideaPicUrl;
    private boolean isPublic;
    private Date createTime;
    private String status;

    public long getIdeaId() {
        return ideaId;
    }

    public void setIdeaId(long ideaId) {
        this.ideaId = ideaId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getIdeaName() {
        return ideaName;
    }

    public void setIdeaName(String ideaName) {
        this.ideaName = ideaName;
    }

    public String getIdeaPicUrl() {
        return ideaPicUrl;
    }

    public void setIdeaPicUrl(String ideaPicUrl) {
        this.ideaPicUrl = ideaPicUrl;
    }

    public boolean getIsPublic() {
        return isPublic;
    }

    public void setIsPublic(boolean isPublic) {
        this.isPublic = isPublic;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
