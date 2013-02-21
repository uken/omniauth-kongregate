# OmniAuth::Kongregate ![CI status](https://secure.travis-ci.org/uken/omniauth-kongregate.png)

OmniAuth strategy for [Kongregate](http://www.kongregate.com) authentication

## Usage

Current version is mostly focused on auto-detecting the logged-in user when the application is running on a canvas.

Just add the provider as usual, passing your app's Kongregate API key (add `/api` to the URL to get it). For example:

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :kongregate, 'YOUR_API_KEY'
    end

When your game is first open on Kongregate, redirect to `/auth/kongregate` (preserving the `kongregate_user_id` and `kongregate_game_auth_token` parameters) to perform the authentication.

If the token is valid, `/auth/kongregate/callback` will fire. You can get the validated user_id and the username there with:

    auth = request.env['omniauth.auth']
    user_id = auth.uid
    username = auth.extras['username']
    
### Guest Access

Guest access (users that are not logged in on Kongregate) will result in an auto-generated, non-numeric value in `user_id` (so it won't clash with `kongregate_user_id`), prefixed with "g_", so applications have a set of temporary credentials until the user decides to authenticate.

## TODO

- Display the Kongregate login form for non-authenticated users


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Special Thanks

- [pmariano](http://github.com/uken/pmariano), for implementing guest access.
