//
//  CCBNodeTempBase.h
//  cpp
//
//  Created by Higgx on 11/4/13.
//
//

#ifndef __cpp__CCBNodeTempBase__
#define __cpp__CCBNodeTempBase__


#include "CUIBaseDelegate.h"

[[include]]

using namespace std;
USING_NS_CC;
USING_NS_CC_EXT;

class CCBNodeTempBase
:public CUIBaseDelegate
{
public:
    CCB_STATIC_NEW_AUTORELEASE_OBJECT_WITH_INIT_METHOD(CCBNodeTempBase, create);
    CCBNodeTempBase();
    virtual ~CCBNodeTempBase();
    
    void* userBag;
    
    virtual cocos2d::SEL_MenuHandler onResolveCCBCCMenuItemSelector(cocos2d::CCObject * pTarget, const char * pSelectorName);
    virtual cocos2d::extension::SEL_CCControlHandler onResolveCCBCCControlSelector(cocos2d::CCObject * pTarget, const char * pSelectorName);
    virtual bool onAssignCCBMemberVariable(cocos2d::CCObject * pTarget, const char * pMemberVariableName, cocos2d::CCNode * pNode);
    virtual cocos2d::SEL_CallFuncN onResolveCCBCCCallFuncSelector(CCObject * pTarget, const char* pSelectorName);
    
    virtual bool onAssignCCBCustomProperty(CCObject* pTarget, const char* pMemberVariableName, cocos2d::extension::CCBValue* pCCBValue);
    virtual void onNodeLoaded(cocos2d::CCNode * pNode, cocos2d::extension::CCNodeLoader * pNodeLoader);
    virtual void completedAnimationSequenceNamed(const char *name);

/*******************************************/

//    SEL_CCControlHandler
//    SEL_CallFuncN
    
/*******************************************/
    
public:
    
	[[value]]
    
    [[properties]]
    
	[[selector]]
    
    [[callback]]
};

#endif /* defined(__cpp__CCBNodeTempBase__) */
