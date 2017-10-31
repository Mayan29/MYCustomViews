# MYCustomViews


### 01. MYScrollPageView（封装带标题滑动翻页控件）

仿新闻 APP 首页，滑动控件，标题栏和内容联动

![01.gif](https://github.com/Mayan29/MYCustomViews/blob/master/DATA/01.gif)


### 02. MYWaterFall（封装瀑布流）

未完成功能：

- 最后一列图片底部没有对齐
- 没有将列数和每个 item 的高度通过代理抽出来，只是在封装类中固定

![02.gif](https://github.com/Mayan29/MYCustomViews/blob/master/DATA/02.gif)


### 03. MYParticleAnimation（封装粒子动画）

未完成功能：

- 最最简单的封装星星冒泡动画开始和停止，没有添加复杂的功能
- 尚未添加雪花、烟花、火焰等效果

![03.gif](https://github.com/Mayan29/MYCustomViews/blob/master/DATA/03.gif)


### 04. MYGiftKeyboard（直播礼物键盘）

仿目前主流直播 APP 礼物键盘，model 和 cell 在接入项目时需要再完善

![04.gif](https://github.com/Mayan29/MYCustomViews/blob/master/DATA/04.gif)

### 05. MYChatToolsView（自定义键盘工具栏输入框）

实现原理是，封装的控件 chatToolsView 是 frame 为 CGRectZero 的 UITextField，主要用途是抛砖引玉，实现调出键盘，内部封装一个私有 UITextField 才是真正的显示控件，将其设置为 chatToolsView 的 inputAccessoryView

缺点很明显，UITextField 不能换行，只能实现简单的单行输入显示；优点是控件调用顺畅，简单。

![05.gif](https://github.com/Mayan29/MYCustomViews/blob/master/DATA/05.gif)

### 06. MYPlacehoderTextView（带占位符的 UITextView）

有好多种方法可以实现 UITextView 添加占位符，这个控件是使用 `drawRect:` 将文字画到 UITextView 上，个人觉得比其他方法在性能上能略微高效些。

![06.gif](https://github.com/Mayan29/MYCustomViews/blob/master/DATA/06.gif)

### 07. MYChatToolsView 2.0（自定义键盘工具栏输入框 2.0 版本）

相比 05. MYChatToolsView 优化了代码逻辑，实现输入文字换行，输入框随着文字换行高度改变。

缺点是，没有实现限制文字换行行数，因为设置限制后，到达限制行数的时候文字不美观，后续调整吧，先不做处理了。

![07.gif](https://github.com/Mayan29/MYCustomViews/blob/master/DATA/07.gif)

### 08. MYIMManager（简单实现 IM 服务端和客户端）

使用 CocoaAsyncSocket 简单实现 IM 服务端和客户端。

![08.gif](https://github.com/Mayan29/MYCustomViews/blob/master/DATA/08.gif)

### 09. MYGiftNumberLabel（礼物连击数字动画）

实现原理是重写 UILabel，将文字画两遍，从而实现文字边框效果

![09.gif](https://github.com/Mayan29/MYCustomViews/blob/master/DATA/09.gif)
