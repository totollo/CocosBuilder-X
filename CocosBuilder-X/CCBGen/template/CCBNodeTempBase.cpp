//
//  CCBNodeTempBase.cpp
//  cpp
//
//  Created by Higgx on 11/4/13.
//
//

#include "CCBNodeTempBase.h"

USING_NS_CC;
USING_NS_CC_EXT;

CCBNodeTempBase::CCBNodeTempBase()
: userBag(NULL)
[[null]]
{
    
}

CCBNodeTempBase::~CCBNodeTempBase(){
    [[release]]
}

void CCBNodeTempBase::onNodeLoaded(cocos2d::CCNode *pNode, cocos2d::extension::CCNodeLoader *pNodeLoader){
    
}

void CCBNodeTempBase::completedAnimationSequenceNamed(const char *name){
        printf("finished animation : %s\n",name);
}

SEL_MenuHandler CCBNodeTempBase::onResolveCCBCCMenuItemSelector(cocos2d::CCObject *pTarget, const char *pSelectorName){
    return NULL;
}

SEL_CCControlHandler CCBNodeTempBase::onResolveCCBCCControlSelector(cocos2d::CCObject *pTarget, const char *pSelectorName){
	[[selector2]]
    return NULL;
}

SEL_CallFuncN CCBNodeTempBase::onResolveCCBCCCallFuncSelector(cocos2d::CCObject *pTarget, const char *pSelectorName){
    [[callback2]]
    return NULL;
}

bool CCBNodeTempBase::onAssignCCBMemberVariable(cocos2d::CCObject *pTarget, const char *pMemberVariableName, cocos2d::CCNode *pNode){
    [[value]]
    return false;
}

bool CCBNodeTempBase::onAssignCCBCustomProperty(cocos2d::CCObject *pTarget, const char *pMemberVariableName, cocos2d::extension::CCBValue *pCCBValue){
    
    bool bRet = false;
    if (pTarget == this)
    {
        [[properties]]
    }
    
    return bRet;
}

[[selector]]

[[callback]]
