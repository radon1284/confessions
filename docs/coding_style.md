### Coding style

1. Make sure that your code editor picks up the ```.editorconfig``` file - there are plugins for all popular code editors. You can test it by adding a couple of spaces at the end of a line - it should be removed automatically on save.
2. Run the tests before pushing the code.
3. Run ```rubocop``` before pushing the code. Any offence will fail the build on Travis.
4. Write a test for every change you introduce unless you have a very good reason to keep the given code untested (for example it's a boilerplate code).
5. Don't use Active Record callbacks at all.
6. Don't put your business logic code in the models - use service objects for that.
7. Keep your controllers thin.
8. Avoid these mistakes http://blog.sundaycoding.com/blog/2015/01/31/11-easy-to-fix-ruby-slash-ruby-on-rails-mistakes/
