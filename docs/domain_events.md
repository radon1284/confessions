### Domain events

In this application we store domain / business events for the key actions which can be performed. When you update existing data (for example record in the database), you lose the history - the only thing which you have is the current state. When you decide to store the events and recompute the current state by applying these events you have the possibility to debug the steps which led to the current state and to go back to any previous state.

That's why we don't create `Order` when an item is added to the cart. The cart is computed by applying the events which affect it. We create `Order` only when a user pays for the cart. `Order` is meant to be immutable - once it's created we don't modify it.

Of course, this approach is not necessary in all the cases as it introduces some complexity. You should not follow this approach when you care only about the current state.

#### Adding a new event

Event classes are stored in ```app/events``` directory. They have to respond to ```visitor``` and ```payload``` in order to be persisted by ```PersistEvent``` service object.

Handlers for events are defined in ```config/initializers/event_handlers.rb```. There are no default handlers - you have to add ```PersistEvent``` there if you want the event to be saved in the database.

In order to publish an event:

```ruby
EventPublisher.publish(CartCleared.new(visitor))
```
