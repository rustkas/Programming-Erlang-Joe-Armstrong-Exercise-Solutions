Using `typer` and `dialyzer` is realy up code understanding and quality.

There are commands which are useful while studing this source code files content.
```
dialyzer --no_check_plt
dialyzer --no_check_plt world.erl
typer world.erl && dialyzer --no_check_plt world.erl
typer dog.erl && dialyzer --no_check_plt dog.erl
typer rabbit.erl && dialyzer --no_check_plt rabbit.erl
typer person.erl && dialyzer --no_check_plt rabbit.erl
typer afile_server.erl
typer afile_client.erl
typer -r ./cd
dialyzer -r ./ --no_check_plt
dialyzer -c ./ --no_check_plt
dialyzer -I ./ --no_check_plt
dialyzer -I client-server --no_check_plt --src
dialyzer --no_check_plt --src
dialyzer --no_check_plt --src ./
dialyzer --no_check_plt --src rabbit.erl
typer rabbit.erl
```
