#include "GSVolBar.h"

static BOOL YTMU(NSString *key) {
    NSDictionary *YTMUltimateDict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"YTMUltimate"];
    return [YTMUltimateDict[key] boolValue];
}

static BOOL volumeBar = YTMU(@"YTMUltimateIsEnabled") && YTMU(@"volBar");

@interface YTMWatchView: UIView
@property (readonly, nonatomic) BOOL isExpanded;
@property (nonatomic, strong) UIView *tabView;
@property (nonatomic) long long currentLayout;
@property (nonatomic, strong) GSVolBar *volumeBar;

- (void)updateVolBarVisibility;
@end

%hook YTMWatchView
%property (nonatomic, strong) GSVolBar *volumeBar;

- (instancetype)initWithColorScheme:(id)scheme {
    self = %orig;

    if (self && volumeBar) {
        self.volumeBar = [[GSVolBar alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - (self.frame.size.width / 2) / 2, 0, self.frame.size.width / 2, 25)];
        [self addSubview:self.volumeBar];
    }

    return self;
}

- (void)layoutSubviews {
    %orig;

    if (volumeBar) {
        self.volumeBar.frame = CGRectMake(self.frame.size.width / 2 - (self.frame.size.width / 2) / 2, CGRectGetMinY(self.tabView.frame) - 25, self.frame.size.width / 2, 25);
    }
}

- (void)updateColorsAfterLayoutChangeTo:(long long)arg1 {
    %orig;

    if (volumeBar) {
        [self updateVolBarVisibility];
    }
}

- (void)updateColorsBeforeLayoutChangeTo:(long long)arg1 {
    %orig;

    if (volumeBar) {
        self.volumeBar.hidden = YES;
    }
}

%new
- (void)updateVolBarVisibility {
    if (volumeBar) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.volumeBar.hidden = !(self.isExpanded && self.currentLayout == 2);
        });
    }
}
%end

// Logos generated property & method hooks with VLA fix
__attribute__((constructor)) static void _logos_method_init() {
    Class _logos_class$_ungrouped$YTMWatchView = objc_getClass("YTMWatchView");

    // Add property manually
    objc_property_attribute_t _attributes[16];
    unsigned int attrc = 0;
    _attributes[attrc++] = (objc_property_attribute_t){ "T", "@\"GSVolBar\"" };
    _attributes[attrc++] = (objc_property_attribute_t){ "&", "" };
    _attributes[attrc++] = (objc_property_attribute_t){ "N", "" };
    class_addProperty(_logos_class$_ungrouped$YTMWatchView, "volumeBar", _attributes, attrc);

    // Fixed-size array instead of variable-length array
    char _typeEncoding[1024];

    snprintf(_typeEncoding, sizeof(_typeEncoding), "%s@:", @encode(GSVolBar *));
    class_addMethod(_logos_class$_ungrouped$YTMWatchView, @selector(volumeBar),
        (IMP)&_logos_property$_ungrouped$YTMWatchView$volumeBar, _typeEncoding);

    snprintf(_typeEncoding, sizeof(_typeEncoding), "v@:%s", @encode(GSVolBar *));
    class_addMethod(_logos_class$_ungrouped$YTMWatchView, @selector(setVolumeBar:),
        (IMP)&_logos_property$_ungrouped$YTMWatchView$setVolumeBar, _typeEncoding);

    // Hook methods
    MSHookMessageEx(_logos_class$_ungrouped$YTMWatchView, @selector(initWithColorScheme:),
                    (IMP)&_logos_method$_ungrouped$YTMWatchView$initWithColorScheme$,
                    (IMP*)&_logos_orig$_ungrouped$YTMWatchView$initWithColorScheme$);

    MSHookMessageEx(_logos_class$_ungrouped$YTMWatchView, @selector(layoutSubviews),
                    (IMP)&_logos_method$_ungrouped$YTMWatchView$layoutSubviews,
                    (IMP*)&_logos_orig$_ungrouped$YTMWatchView$layoutSubviews);

    MSHookMessageEx(_logos_class$_ungrouped$YTMWatchView, @selector(updateColorsAfterLayoutChangeTo:),
                    (IMP)&_logos_method$_ungrouped$YTMWatchView$updateColorsAfterLayoutChangeTo$,
                    (IMP*)&_logos_orig$_ungrouped$YTMWatchView$updateColorsAfterLayoutChangeTo$);

    MSHookMessageEx(_logos_class$_ungrouped$YTMWatchView, @selector(updateColorsBeforeLayoutChangeTo:),
                    (IMP)&_logos_method$_ungrouped$YTMWatchView$updateColorsBeforeLayoutChangeTo$,
                    (IMP*)&_logos_orig$_ungrouped$YTMWatchView$updateColorsBeforeLayoutChangeTo$);

    // updateVolBarVisibility method
    snprintf(_typeEncoding, sizeof(_typeEncoding), "v@:");
    class_addMethod(_logos_class$_ungrouped$YTMWatchView, @selector(updateVolBarVisibility),
                    (IMP)&_logos_method$_ungrouped$YTMWatchView$updateVolBarVisibility,
                    _typeEncoding);
}
