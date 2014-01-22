//
//  CCBNodeTemp.h
//  cpp
//
//  Created by Higgx on 11/4/13.
//
//

#ifndef __cpp__CCBNodeTemp__
#define __cpp__CCBNodeTemp__


#include "CCBNodeTempBase.h"
#include "MyView.h"

using namespace std;
USING_NS_CC;
USING_NS_CC_EXT;

class CCBNodeTemp
:public CCBNodeTempBase
,public MyView
{
public:
    CCB_STATIC_NEW_AUTORELEASE_OBJECT_WITH_INIT_METHOD(CCBNodeTemp, create);
    CCBNodeTemp();
    
    virtual void onNodeLoaded(cocos2d::CCNode * pNode, cocos2d::extension::CCNodeLoader * pNodeLoader);
    virtual void completedAnimationSequenceNamed(const char *name);

/*******************************************/
//    SEL_CCControlHandler
//    SEL_CallFuncN
/*******************************************/
    
public:
    
	[[selector]]
    
    [[callback]]
};

#endif /* defined(__cpp__CCBNodeTemp__) */
