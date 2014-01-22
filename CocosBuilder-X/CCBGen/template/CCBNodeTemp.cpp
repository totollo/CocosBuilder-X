//
//  CCBNodeTemp.cpp
//  cpp
//
//  Created by Higgx on 11/4/13.
//
//

#include "CCBNodeTemp.h"

USING_NS_CC;
USING_NS_CC_EXT;

CCBNodeTemp::CCBNodeTemp()
{
    
}

void CCBNodeTemp::onNodeLoaded(cocos2d::CCNode *pNode, cocos2d::extension::CCNodeLoader *pNodeLoader){
    
}

void CCBNodeTemp::completedAnimationSequenceNamed(const char *name){
        printf("finished animation : %s\n",name);
}

[[selector]]

[[callback]]
