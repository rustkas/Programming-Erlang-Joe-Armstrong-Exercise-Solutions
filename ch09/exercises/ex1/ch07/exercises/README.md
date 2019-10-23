Useful commands:
```
typer kas_bits_to_reverese.erl
dialyzer --no_check_plt --src kas_bits_to_reverese.erl

typer kas_byte_reverse.erl
dialyzer --no_check_plt --src kas_byte_reverse.erl

typer kas_packet_to_term.erl
dialyzer --no_check_plt --src kas_packet_to_term.erl kas_term_to_packet.erl

typer kas_term_to_packet.erl
dialyzer --no_check_plt --src kas_term_to_packet.erl

typer kas_packet_to_term.erl
dialyzer --no_check_plt --src kas_packet_to_term.erl

typer kas_test_packet_conversion.erl
dialyzer --no_check_plt --src kas_test_packet_conversion.erl kas_term_to_packet.erl

```

Dialyzer helped fix a hidden bug in my code (kas_bits_to_reverese).

