var search_data = {"index":{"searchIndex":["object","sleeperrb","badrequest","client","notfound","ratelimitexceeded","resources","avatar","league","nflstate","user","servererror","utilities","cache","classmethods","request","avatar()","cached_attr()","included()","league()","leagues()","new()","new()","new()","nfl_state()","refresh()","refresh()","user()","changelog","code_of_conduct","gemfile","gemfile.lock","license","readme","rakefile","setup","application.css","application.js","index.html"],"longSearchIndex":["object","sleeperrb","sleeperrb::badrequest","sleeperrb::client","sleeperrb::notfound","sleeperrb::ratelimitexceeded","sleeperrb::resources","sleeperrb::resources::avatar","sleeperrb::resources::league","sleeperrb::resources::nflstate","sleeperrb::resources::user","sleeperrb::servererror","sleeperrb::utilities","sleeperrb::utilities::cache","sleeperrb::utilities::cache::classmethods","sleeperrb::utilities::request","sleeperrb::client#avatar()","sleeperrb::utilities::cache::classmethods#cached_attr()","sleeperrb::utilities::cache::included()","sleeperrb::client#league()","sleeperrb::resources::user#leagues()","sleeperrb::resources::avatar::new()","sleeperrb::resources::league::new()","sleeperrb::resources::user::new()","sleeperrb::client#nfl_state()","sleeperrb::resources::user#refresh()","sleeperrb::utilities::cache#refresh()","sleeperrb::client#user()","","","","","","","","","","",""],"info":[["Object","","Object.html","",""],["SleeperRb","","SleeperRb.html","",""],["SleeperRb::BadRequest","","SleeperRb/BadRequest.html","",""],["SleeperRb::Client","","SleeperRb/Client.html","","<p>A SleeperRb::Client instance is the interface for formulating all requests for Sleeper data.\n"],["SleeperRb::NotFound","","SleeperRb/NotFound.html","",""],["SleeperRb::RateLimitExceeded","","SleeperRb/RateLimitExceeded.html","",""],["SleeperRb::Resources","","SleeperRb/Resources.html","",""],["SleeperRb::Resources::Avatar","","SleeperRb/Resources/Avatar.html","","<p>The Avatar class allows access to full-size or thumbnail URLs for user avatars.\n"],["SleeperRb::Resources::League","","SleeperRb/Resources/League.html","","<p>This class represents a Fantasy Football League and is the access point for associated resources.\n"],["SleeperRb::Resources::NflState","","SleeperRb/Resources/NflState.html","","<p>The NflState resource represents the current state of the NFL (week number, year, etc) as defined by …\n"],["SleeperRb::Resources::User","","SleeperRb/Resources/User.html","","<p>The User resource represents a single user in Sleeper. This also serves as the access points for associated …\n"],["SleeperRb::ServerError","","SleeperRb/ServerError.html","",""],["SleeperRb::Utilities","","SleeperRb/Utilities.html","",""],["SleeperRb::Utilities::Cache","","SleeperRb/Utilities/Cache.html","","<p>This module encapsulates the logic for caching and refreshing values retrieved from the Sleeper API. …\n"],["SleeperRb::Utilities::Cache::ClassMethods","","SleeperRb/Utilities/Cache/ClassMethods.html","","<p>Methods to be extended into the class when included.\n"],["SleeperRb::Utilities::Request","","SleeperRb/Utilities/Request.html","","<p>This module encapsulates the logic for handling the response when querying from the Sleeper API.\n"],["avatar","SleeperRb::Client","SleeperRb/Client.html#method-i-avatar","(avatar_id)","<p>Returns an avatar found by the alphanumeric ID.\n<p>@param avatar_id [String] The ID for the avatar\n<p>@return …\n"],["cached_attr","SleeperRb::Utilities::Cache::ClassMethods","SleeperRb/Utilities/Cache/ClassMethods.html#method-i-cached_attr","(*attrs)","<p>Creates a memoized attribute reader for the named attributes.\n<p>Example\n<p>+cached_attr :display_name, :username+ …\n"],["included","SleeperRb::Utilities::Cache","SleeperRb/Utilities/Cache.html#method-c-included","(base)",""],["league","SleeperRb::Client","SleeperRb/Client.html#method-i-league","(league_id)","<p>Returns a League found by the alphanumeric ID.\n<p>@param league_id [String] The ID for the League\n<p>@return …\n"],["leagues","SleeperRb::Resources::User","SleeperRb/Resources/User.html#method-i-leagues","(season)","<p>Retrieves leagues for the user for the given season.\n<p>@param season [String] The year in which the leagues …\n"],["new","SleeperRb::Resources::Avatar","SleeperRb/Resources/Avatar.html#method-c-new","(avatar_id)","<p>Initializes an avatar using an avatar_id.\n<p>@param avatar_id [String] The alphanumeric ID for the avatar …\n"],["new","SleeperRb::Resources::League","SleeperRb/Resources/League.html#method-c-new","(opts)",""],["new","SleeperRb::Resources::User","SleeperRb/Resources/User.html#method-c-new","(user_id: nil, username: nil)","<p>Initializes a user, with either username or user_id.\n<p>@param username [String] The current username\n<p>@param …\n"],["nfl_state","SleeperRb::Client","SleeperRb/Client.html#method-i-nfl_state","()","<p>Returns the current NflState.\n<p>@return SleeperRb::Resources::NflState The NflState instance\n"],["refresh","SleeperRb::Resources::User","SleeperRb/Resources/User.html#method-i-refresh","()","<p>Clears leagues for the user and returns itself.\n<p>@return [self]\n"],["refresh","SleeperRb::Utilities::Cache","SleeperRb/Utilities/Cache.html#method-i-refresh","()","<p>Refreshes all memoized values set by cached_attr.\n"],["user","SleeperRb::Client","SleeperRb/Client.html#method-i-user","(username: nil, user_id: nil)","<p>Returns a user found by either username or user_id. Usernames are subject to change and are thus unstable. …\n"],["CHANGELOG","","CHANGELOG_md.html","","<p>[Unreleased]\n<p>[0.1.0] - 2021-09-02\n<p>Initial release\n"],["CODE_OF_CONDUCT","","CODE_OF_CONDUCT_md.html","","<p>Contributor Covenant Code of Conduct\n<p>Our Pledge\n<p>We as members, contributors, and leaders pledge to make …\n"],["Gemfile","","Gemfile.html","","<p># frozen_string_literal: true\n<p>source “rubygems.org”\n<p># Specify your gem&#39;s dependencies in …\n"],["Gemfile.lock","","Gemfile_lock.html","","<p>PATH\n\n<pre>remote: .\nspecs:\n  sleeper_rb (0.1.0)</pre>\n<p>GEM\n"],["LICENSE","","LICENSE_txt.html","","<p>The MIT License (MIT)\n<p>Copyright © 2021 Stephen Weil\n<p>Permission is hereby granted, free of charge, to …\n"],["README","","README_md.html","","<p>SleeperRb\n<p><img src=\"https://badge.fury.io/rb/sleeper_rb.svg\">\n<img src=\"https://app.travis-ci.com/sjweil9/sleeper_rb.svg?branch=main\"> ...\n"],["Rakefile","","Rakefile.html","","<p># frozen_string_literal: true\n<p>require “bundler/gem_tasks” require “rspec/core/rake_task” …\n"],["setup","","bin/setup.html","","<p>#!/usr/bin/env bash set -euo pipefail IFS=$&#39;nt&#39; set -vx\n<p>bundle install\n<p># Do any other automated …\n"],["application.css","","coverage/assets/0_12_3/application_css.html","","<p>html,body,div,span,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,code,del,dfn,em,img,q,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,dialog,figure,footer,header,hgroup,nav,section{margin:0;padding:0;border:0;font-weight:inherit;font-style:inherit;font-size:100%;font-family:inherit;vertical-align:baseline}article,aside,dialog,figure,footer,header,hgroup,nav,section{display:block}body{line-height:1.5}table{border-collapse:separate;border-spacing:0}caption,th,td{text-align:left;font-weight:normal}table,td,th{vertical-align:middle}blockquote:before,blockquote:after,q:before,q:after{content:“”}blockquote,q{quotes:“” …\n"],["application.js","","coverage/assets/0_12_3/application_js.html","","<p>!function(e,t)“use strict”;“object”==typeof module&&“object”==typeof module.exports?module.exports=e.document?t(e,!0):function(e){if(!e.document)throw …\n"],["index.html","","coverage/index_html.html","","<p>&lt;!DOCTYPE html&gt; &lt;html xmlns=&#39;www.w3.org/1999/xhtml&#39;&gt;\n\n<pre>&lt;head&gt;\n  &lt;title&gt;Code coverage ...</pre>\n"]]}}