# MVVMReactiveCocoa
此工程用于演示MVVM架构模式结合ReactiveCocoa函数响应式编程开发的方法，主要演示了两个界面：
1. 登录界面，测试输入框颜色变化，按钮响应处理和登录逻辑控制等。
2. 分页数据类型的表视图界面，测试上下拉刷新，请求分页数据等。




# 一、项目需求：

#### 登录界面：
1. 实时监测用户名、密码输入框的文本有效性，并在不同状态下切换输入框的背景色。
2. 实时监测登录按钮的可点击性，用户名只有在用户名和密码都有效的情况下才能点击。
3. 登录按钮的背景色跟随其可点击性更换背景色。
4. 点击登录按钮之后检查登录信息是否正确，错误的情况下显示错误提示信息。
5. 点击登录成功之后，跳转进入下一界面。

#### 分页表视图界面：
1. 结合MVVM架构模式，在ViewModel中处理分页加载数据和表视图的代理方法。
2. 处理ViewModel与控制器对象之间的各种交互。

# 二、运行
登录页密码：使用输入框内的默认提示即可


# 三、效果图：
![image](https://github.com/DreamcoffeeZS/MVVMReactiveCocoa/blob/master/Screenshots/RACAndMVVM.jpg)



