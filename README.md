# TranstioningAnimationDemo2
转场动画基础用法-Push

本文参考自[iOS动画指南 - 6.可以很酷的转场动画](http://www.jianshu.com/p/802d47f0f311)
原文是用swift写的代码，这里转换成oc代码实现。还有一些细节上不一样的地方，不尽相同。
> 要自定义push动画，需实现导航控制器的代理协议`<UINavigationControllerDelegate>`

```objc
@interface ViewController () <UINavigationControllerDelegate>

...
self.navigationController.delegate = self;
...

// 返回一个不可交互的转场动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
     return ...;
}

// 返回一个可以交互的转场动画
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
     return ...;
}
```

然后只要执行这句：
```[self.navigationController pushViewController:vc animated:YES];```
导航控制器就会调用上述协议方法获取动画来执行。

> 对于不需要交互式过程、只是自动完成的动画，那么创建一个实现了`<UIViewControllerAnimatedTransitioning>`协议的对象返回给导航控制器就ok。

```objc
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 返回动画持续时间;
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 编写动画逻辑
}
```
> 而对于可交互式动画，则需要让上述的不可交互动画类继承自`UIPercentDrivenInteractiveTransition`，个人猜测它可以按照progress(动画进度)来分解动画，只需要我们把交互的进度告诉它，它就可以只显示动画过程对应的那一瞬间。

```objc
[self updateInteractiveTransition:progress];
```
我们不断更新progress，它就可以不断更新动画过程进度。
当然，也可以在解发到某个逻辑时让它取消
```objc
self.completionSpeed = -1.0;
[self cancelInteractiveTransition];
```
或者让它立即完成余下的动画
```objc
self.completionSpeed = 1.0;
[self finishInteractiveTransition];
```
![TransitioningAnimationDemo2.gif](https://github.com/JiongXing/TranstioningAnimationDemo2/raw/master/screenshots/TransitioningAnimationDemo2.gif)

