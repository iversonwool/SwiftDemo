//
//  main.swift
//  25.AccessControl
//
//  Created by LeeHow on 2018/8/28.
//  Copyright © 2018 LeeHow. All rights reserved.
//

import Foundation

print("Hello, World!")

//模块和源文件


//访问级别
//Open Public
//Internal
//File-private
//Private


//Open 只能作用于类和类的成员，它和 Public 的区别如下：
//
//Public 或者其它更严访问级别的类，只能在其定义的模块内部被继承。
//Public 或者其它更严访问级别的类成员，只能在其定义的模块内部的子类中重写。
//Open 的类，可以在其定义的模块中被继承，也可以在引用它的模块中被继承。
//Open 的类成员，可以在其定义的模块中子类中重写，也可以在引用它的模块中的子类重写。


//
//除非专门指定，否则实体默认的访问级别为 internal，可以查阅默认访问级别这一节。
//



public class somePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivatreClass {}
//高-不严格
//低-严格



//访问级别基本原则
//
//Swift 中的访问级别遵循一个基本原则：不可以在某个实体中定义访问级别更低（更严格）的实体。
//
//例如：
//
//一个 Public 的变量，其类型的访问级别不能是 Internal，File-private 或是 Private。
//因为无法保证变量的类型在使用变量的地方也具有访问权限。
//函数的访问级别不能高于它的参数类型和返回类型的访问级别。
//因为这样就会出现函数可以在任何地方被访问，但是它的参数类型和返回类型却不可以的情况。
//关于此原则在各种情况下的具体表现，将在下文有所体现。
//

//默认访问级别
//
//如果你没有为代码中的实体显式指定访问级别，那么它们默认为 internal 级别（有一些例外情况，稍后会进行说明）。
//因此，在大多数情况下，我们不需要显式指定实体的访问级别。

































