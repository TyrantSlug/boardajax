package com.lime.account.vo;

public class AccountVO {
		
    private Integer accountSeq; 
    private String profitCost;
    private String bigGroup;
    private String middleGroup;
    private String smallGroup;
    private String detailGroup;
    private String comments;
    private String transactionMoney; 
    private String transactionDate;
    private String writer;
    private String regDate;

    public Integer getAccountSeq() {
        return accountSeq;
    }

    public void setAccountSeq(Integer accountSeq) {
        this.accountSeq = accountSeq;
    }

    public String getProfitCost() {
        return profitCost;
    }

    public void setProfitCost(String profitCost) {
        this.profitCost = profitCost;
    }

    public String getBigGroup() {
        return bigGroup;
    }

    public void setBigGroup(String bigGroup) {
        this.bigGroup = bigGroup;
    }

    public String getMiddleGroup() {
        return middleGroup;
    }

    public void setMiddleGroup(String middleGroup) {
        this.middleGroup = middleGroup;
    }

    public String getSmallGroup() {
        return smallGroup;
    }

    public void setSmallGroup(String smallGroup) {
        this.smallGroup = smallGroup;
    }

    public String getDetailGroup() {
        return detailGroup;
    }

    public void setDetailGroup(String detailGroup) {
        this.detailGroup = detailGroup;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getTransactionMoney() {
        return transactionMoney;
    }

    public void setTransactionMoney(String transactionMoney) {
        this.transactionMoney = transactionMoney;
    }

    public String getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(String transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

}

