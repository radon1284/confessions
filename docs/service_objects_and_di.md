### Service objects and dependency injection

Please start by reading http://blog.sundaycoding.com/blog/2014/11/25/my-take-on-services-in-rails/ to understand the initial approach.

Now instead of calling

```ruby
RestoreCart.build
```

call

```ruby
DI.get(RestoreCart)
```

```DI``` is a simple proxy which by default returns ```clazz.build``` when ```clazz``` is passed to it.

The reason for this ```DI``` proxy is that in tests you can override the resolution of any service object with your own mock:

```ruby
DI.add_override(MakeStripePayment, ->(param1, param2, param3) { puts "payment made!" })
```
