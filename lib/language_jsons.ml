let ocaml_interface =
  `Assoc
    [
      ("name", `String "OCaml Interface");
      ("scopeName", `String "source.ocaml.interface");
      ("fileTypes", `List [ `String "mli"; `String "eliomi" ]);
      ( "patterns",
        `List
          [
            `Assoc [ ("include", `String "source.ocaml#directives") ];
            `Assoc [ ("include", `String "source.ocaml#comments") ];
            `Assoc [ ("include", `String "source.ocaml#attributes") ];
            `Assoc [ ("include", `String "source.ocaml#extensions") ];
            `Assoc [ ("include", `String "#bindings") ];
            `Assoc [ ("include", `String "source.ocaml#operators") ];
            `Assoc [ ("include", `String "#keywords") ];
            `Assoc [ ("include", `String "source.ocaml#types") ];
            `Assoc [ ("include", `String "source.ocaml#identifiers") ];
          ] );
      ( "repository",
        `Assoc
          [
            ( "bindings",
              `Assoc
                [
                  ( "comment",
                    `String
                      "bindings that are shared between .ml and .mli syntaxes"
                  );
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "optional labeled argument");
                            ("name", `String "variable.parameter.optional.ocaml");
                            ("match", `String "\\?([[:lower:]_][[:word:]']*)?");
                          ];
                        `Assoc
                          [
                            ("comment", `String "labeled argument");
                            ("name", `String "variable.parameter.labeled.ocaml");
                            ("match", `String "~([[:lower:]_][[:word:]']*)?");
                          ];
                        `Assoc
                          [
                            ("comment", `String "type declaration");
                            ( "match",
                              `String
                                "\\b(type)[[:space:]]+(nonrec[[:space:]]+)?(_[[:space:]]+|[+-]?'[[:alpha:]][[:word:]']*[[:space:]]+|\\(.*\\)[[:space:]]+)?([[:lower:]_][[:word:]']*)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc
                                      [
                                        ( "patterns",
                                          `List
                                            [
                                              `Assoc
                                                [ ("include", `String "$base") ];
                                            ] );
                                      ] );
                                  ( "4",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "and declaration for let bindings, type \
                                 declarations, class bindings, class type \
                                 definitions, or module constraints" );
                            ( "match",
                              `String
                                "\\b(and)[[:space:]]+(?!(?:module|type|lazy)\\b(?!'))(virtual[[:space:]]+)?(_[[:space:]]+|'[[:alpha:]][[:word:]']*[[:space:]]+|\\(.*\\)[[:space:]]+)?([[:lower:]_][[:word:]']*)(?![[:word:]'])[[:space:]]*(?!,|::|[[:space:]])"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc
                                      [
                                        ( "patterns",
                                          `List
                                            [
                                              `Assoc
                                                [ ("include", `String "$base") ];
                                            ] );
                                      ] );
                                  ( "4",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "external declaration");
                            ( "begin",
                              `String
                                "\\b(external)[[:space:]]+([[:lower:]_][[:word:]']*)?"
                            );
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                            ("end", `String "(?<=]|\")[[:space:]]*(?:$|(?=]))");
                            ( "patterns",
                              `List
                                [
                                  `Assoc
                                    [
                                      ("comment", `String "string literal");
                                      ( "name",
                                        `String "string.quoted.double.ocaml" );
                                      ("begin", `String "\"");
                                      ("end", `String "\"");
                                    ];
                                  `Assoc [ ("include", `String "$base") ];
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "val declaration for class instance variables"
                            );
                            ( "match",
                              `String
                                "\\b(val)[[:space:]]+(virtual)[[:space:]]+(mutable)[[:space:]]+([[:lower:]_][[:word:]']*)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "4",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "val declaration for let bindings or class \
                                 instance variables" );
                            ( "match",
                              `String
                                "\\b(val|val!)[[:space:]]+(mutable[[:space:]]+)?(virtual[[:space:]]+)?([[:lower:]_][[:word:]']*)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "4",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "class method declaration");
                            ( "match",
                              `String
                                "\\b(method)[[:space:]]+(virtual)[[:space:]]+(private)[[:space:]]+([[:lower:]_][[:word:]']*)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "4",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "class method declaration");
                            ( "match",
                              `String
                                "\\b(method|method!)[[:space:]]+(private[[:space:]]+)?(virtual[[:space:]]+)?([[:lower:]_][[:word:]']*)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "4",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "class specification or class type definition \
                                 with type parameters" );
                            ( "match",
                              `String
                                "\\b(class)[[:space:]]*([[:space:]]+type)?([[:space:]]+virtual)?[[:space:]]*(\\[.*\\])[[:space:]]*([[:lower:]_][[:word:]']*)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "4",
                                    `Assoc
                                      [
                                        ( "patterns",
                                          `List
                                            [
                                              `Assoc
                                                [ ("include", `String "$base") ];
                                            ] );
                                      ] );
                                  ( "5",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "class specification or class type definition"
                            );
                            ( "match",
                              `String
                                "\\b(class)[[:space:]]+(type[[:space:]]+)?(virtual[[:space:]]+)?([[:lower:]_][[:word:]']*)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "4",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "named self in object");
                            ( "match",
                              `String
                                "\\b(object)[[:space:]]*\\([[:space:]]*([[:lower:]_][[:word:]']*)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "module type of");
                            ( "begin",
                              `String
                                "\\b(module)[[:space:]]+(type)[[:space:]]+(of)\\b"
                            );
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                ] );
                            ( "end",
                              `String
                                "(?=val|external|type|exception|class|module|open|include|=)"
                            );
                            ( "patterns",
                              `List
                                [
                                  `Assoc [ ("include", `String "source.ocaml") ];
                                ] );
                          ];
                      ] );
                ] );
            ( "keywords",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ( "comment",
                              `String "reserved ocaml keyword (in interfaces)"
                            );
                            ("name", `String "keyword.other.ocaml.interface");
                            ( "match",
                              `String
                                "\\b(and|as|class|constraint|end|exception|external|functor|in|include|inherit|let[[:space:]]+open|method|module|mutable|nonrec|object|of|open|private|rec|sig|type|val|virtual|with)\\b(?!')"
                            );
                          ];
                      ] );
                ] );
          ] );
    ]

let ocaml =
  `Assoc
    [
      ("name", `String "OCaml");
      ("scopeName", `String "source.ocaml");
      ( "fileTypes",
        `List [ `String "ml"; `String "eliom"; `String ".ocamlinit" ] );
      ( "patterns",
        `List
          [
            `Assoc [ ("include", `String "#directives") ];
            `Assoc [ ("include", `String "#comments") ];
            `Assoc [ ("include", `String "#strings") ];
            `Assoc [ ("include", `String "#characters") ];
            `Assoc [ ("include", `String "#attributes") ];
            `Assoc [ ("include", `String "#extensions") ];
            `Assoc [ ("include", `String "#modules") ];
            `Assoc [ ("include", `String "#bindings") ];
            `Assoc [ ("include", `String "#operators") ];
            `Assoc [ ("include", `String "#keywords") ];
            `Assoc [ ("include", `String "#literals") ];
            `Assoc [ ("include", `String "#types") ];
            `Assoc [ ("include", `String "#identifiers") ];
          ] );
      ( "repository",
        `Assoc
          [
            ( "directives",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "line number directive");
                            ( "begin",
                              `String
                                "^[[:space:]]*(#)[[:space:]]*([[:digit:]]+)" );
                            ("end", `String "$");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                  ( "2",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "constant.numeric.decimal.integer.ocaml"
                                        );
                                      ] );
                                ] );
                            ( "contentName",
                              `String "comment.line.directive.ocaml" );
                          ];
                        `Assoc
                          [
                            ("comment", `String "general, loading codes");
                            ( "begin",
                              `String
                                "^[[:space:]]*(#)[[:space:]]*(help|quit|cd|directory|remove_directory|load_rec|load|use|mod_use)"
                            );
                            ("end", `String "$");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                  ( "2",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                ] );
                            ( "patterns",
                              `List
                                [ `Assoc [ ("include", `String "#strings") ] ]
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "environment queries");
                            ( "begin",
                              `String
                                "^[[:space:]]*(#)[[:space:]]*(show_class_type|show_class|show_exception|show_module_type|show_module|show_type|show_val|show)"
                            );
                            ("end", `String "$");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                  ( "2",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                ] );
                            ( "patterns",
                              `List
                                [
                                  `Assoc [ ("include", `String "#types") ];
                                  `Assoc [ ("include", `String "#identifiers") ];
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "pretty-printing, tracing");
                            ( "begin",
                              `String
                                "^[[:space:]]*(#)[[:space:]]*(install_printer|print_depth|print_length|remove_printer|trace|untrace_all|untrace)"
                            );
                            ("end", `String "$");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                  ( "2",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                ] );
                            ( "patterns",
                              `List
                                [
                                  `Assoc [ ("include", `String "#literals") ];
                                  `Assoc [ ("include", `String "#identifiers") ];
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "compiler options");
                            ( "begin",
                              `String
                                "^[[:space:]]*(#)[[:space:]]*(labels|ppx|principal|rectypes|warn_error|warnings)"
                            );
                            ("end", `String "$");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                  ( "2",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                ] );
                            ( "patterns",
                              `List
                                [
                                  `Assoc [ ("include", `String "#strings") ];
                                  `Assoc [ ("include", `String "#literals") ];
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "topfind directives");
                            ( "begin",
                              `String
                                "^[[:space:]]*(#)[[:space:]]*(require|list|camlp4o|camlp4r|predicates|thread)"
                            );
                            ("end", `String "$");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                  ( "2",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                ] );
                            ( "patterns",
                              `List
                                [ `Assoc [ ("include", `String "#strings") ] ]
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "cppo directives");
                            ( "begin",
                              `String
                                "^[[:space:]]*(#)[[:space:]]*(define|undef|ifdef|ifndef|if|else|elif|endif|include|warning|error|ext|endext)"
                            );
                            ("end", `String "$");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                  ( "2",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                ] );
                            ( "patterns",
                              `List
                                [
                                  `Assoc
                                    [
                                      ("name", `String "keyword.other.ocaml");
                                      ("match", `String "\\b(defined)\\b");
                                    ];
                                  `Assoc
                                    [
                                      ("name", `String "keyword.other.ocaml");
                                      ("match", `String "\\\\");
                                    ];
                                  `Assoc [ ("include", `String "#comments") ];
                                  `Assoc [ ("include", `String "#strings") ];
                                  `Assoc [ ("include", `String "#characters") ];
                                  `Assoc [ ("include", `String "#keywords") ];
                                  `Assoc [ ("include", `String "#operators") ];
                                  `Assoc [ ("include", `String "#literals") ];
                                  `Assoc [ ("include", `String "#types") ];
                                  `Assoc [ ("include", `String "#identifiers") ];
                                ] );
                          ];
                      ] );
                ] );
            ( "comments",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "empty comment");
                            ("name", `String "comment.block.ocaml");
                            ("match", `String "\\(\\*\\*\\)");
                          ];
                        `Assoc
                          [
                            ("comment", `String "ocamldoc comment");
                            ("name", `String "comment.doc.ocaml");
                            ("begin", `String "\\(\\*\\*");
                            ("end", `String "\\*\\)");
                            ( "patterns",
                              `List
                                [
                                  `Assoc
                                    [
                                      ( "include",
                                        `String "source.ocaml.ocamldoc#markup"
                                      );
                                    ];
                                  `Assoc
                                    [
                                      ("include", `String "#strings-in-comments");
                                    ];
                                  `Assoc [ ("include", `String "#comments") ];
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "Cinaps comment");
                            ("begin", `String "\\(\\*\\$");
                            ("end", `String "\\*\\)");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "comment.cinaps.ocaml");
                                      ] );
                                ] );
                            ( "endCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "comment.cinaps.ocaml");
                                      ] );
                                ] );
                            ( "patterns",
                              `List [ `Assoc [ ("include", `String "$self") ] ]
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "block comment");
                            ("name", `String "comment.block.ocaml");
                            ("begin", `String "\\(\\*");
                            ("end", `String "\\*\\)");
                            ( "patterns",
                              `List
                                [
                                  `Assoc
                                    [
                                      ("include", `String "#strings-in-comments");
                                    ];
                                  `Assoc [ ("include", `String "#comments") ];
                                ] );
                          ];
                      ] );
                ] );
            ( "strings-in-comments",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "char literal");
                            ("match", `String "'(\\\\)?.'");
                          ];
                        `Assoc
                          [
                            ("comment", `String "string literal");
                            ("begin", `String "\"");
                            ("end", `String "\"");
                            ( "patterns",
                              `List
                                [
                                  `Assoc [ ("match", `String "\\\\\\\\") ];
                                  `Assoc [ ("match", `String "\\\\\"") ];
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "quoted string literal");
                            ("begin", `String "\\{[[:lower:]_]*\\|");
                            ("end", `String "\\|[[:lower:]_]*\\}");
                          ];
                      ] );
                ] );
            ( "strings",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "quoted string literal");
                            ("name", `String "string.quoted.braced.ocaml");
                            ( "begin",
                              `String
                                "\\{(%%?[[:alpha:]_][[:word:]']*(\\.[[:alpha:]_][[:word:]']*)*[[:space:]]*)?[[:lower:]_]*\\|"
                            );
                            ("end", `String "\\|[[:lower:]_]*\\}");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "keyword.other.extension.ocaml" );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "string literal");
                            ("name", `String "string.quoted.double.ocaml");
                            ("begin", `String "\"");
                            ("end", `String "\"");
                            ( "patterns",
                              `List
                                [
                                  `Assoc
                                    [
                                      ("comment", `String "escaped newline");
                                      ( "name",
                                        `String
                                          "constant.character.escape.ocaml" );
                                      ("match", `String "\\\\$");
                                    ];
                                  `Assoc
                                    [
                                      ("comment", `String "escaped backslash");
                                      ( "name",
                                        `String
                                          "constant.character.escape.ocaml" );
                                      ("match", `String "\\\\\\\\");
                                    ];
                                  `Assoc
                                    [
                                      ( "comment",
                                        `String "escaped quote or whitespace" );
                                      ( "name",
                                        `String
                                          "constant.character.escape.ocaml" );
                                      ("match", `String "\\\\[\"'ntbr ]");
                                    ];
                                  `Assoc
                                    [
                                      ( "comment",
                                        `String
                                          "character from decimal ASCII code" );
                                      ( "name",
                                        `String
                                          "constant.character.escape.ocaml" );
                                      ("match", `String "\\\\[[:digit:]]{3}");
                                    ];
                                  `Assoc
                                    [
                                      ( "comment",
                                        `String
                                          "character from hexadecimal ASCII \
                                           code" );
                                      ( "name",
                                        `String
                                          "constant.character.escape.ocaml" );
                                      ("match", `String "\\\\x[[:xdigit:]]{2}");
                                    ];
                                  `Assoc
                                    [
                                      ( "comment",
                                        `String
                                          "character from octal ASCII code" );
                                      ( "name",
                                        `String
                                          "constant.character.escape.ocaml" );
                                      ("match", `String "\\\\o[0-3][0-7]{2}");
                                    ];
                                  `Assoc
                                    [
                                      ( "comment",
                                        `String
                                          "unicode character escape sequence" );
                                      ( "name",
                                        `String
                                          "constant.character.escape.ocaml" );
                                      ( "match",
                                        `String "\\\\u\\{[[:xdigit:]]{1,6}\\}"
                                      );
                                    ];
                                  `Assoc
                                    [
                                      ("comment", `String "printf format string");
                                      ( "name",
                                        `String
                                          "constant.character.printf.ocaml" );
                                      ( "match",
                                        `String
                                          "%[-0+ \
                                           #]*([[:digit:]]+|\\*)?(.([[:digit:]]+|\\*))?[lLn]?[diunlLNxXosScCfFeEgGhHBbat!%@,\
                                           ]" );
                                    ];
                                  `Assoc
                                    [
                                      ( "comment",
                                        `String "unknown escape sequence" );
                                      ( "name",
                                        `String
                                          "invalid.illegal.unknown-escape.ocaml"
                                      );
                                      ("match", `String "\\\\.");
                                    ];
                                ] );
                          ];
                      ] );
                ] );
            ( "characters",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ( "comment",
                              `String "character literal from escaped backslash"
                            );
                            ("name", `String "string.quoted.single.ocaml");
                            ("match", `String "'(\\\\\\\\)'");
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "constant.character.escape.ocaml" );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "character literal from escaped quote or \
                                 whitespace" );
                            ("name", `String "string.quoted.single.ocaml");
                            ("match", `String "'(\\\\[\"'ntbr ])'");
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "constant.character.escape.ocaml" );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "character literal from decimal ASCII code" );
                            ("name", `String "string.quoted.single.ocaml");
                            ("match", `String "'(\\\\[[:digit:]]{3})'");
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "constant.character.escape.ocaml" );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "character literal from hexadecimal ASCII code"
                            );
                            ("name", `String "string.quoted.single.ocaml");
                            ("match", `String "'(\\\\x[[:xdigit:]]{2})'");
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "constant.character.escape.ocaml" );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String "character literal from octal ASCII code"
                            );
                            ("name", `String "string.quoted.single.ocaml");
                            ("match", `String "'(\\\\o[0-3][0-7]{2})'");
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "constant.character.escape.ocaml" );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "character literal from unknown escape sequence"
                            );
                            ("name", `String "string.quoted.single.ocaml");
                            ("match", `String "'(\\\\.)'");
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "invalid.illegal.unknown-escape.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "character literal");
                            ("name", `String "string.quoted.single.ocaml");
                            ("match", `String "'.'");
                          ];
                      ] );
                ] );
            ( "attributes",
              `Assoc
                [
                  ( "begin",
                    `String
                      "\\[(@|@@|@@@)[[:space:]]*([[:alpha:]_]+(\\.[[:word:]']+)*)"
                  );
                  ("end", `String "\\]");
                  ( "beginCaptures",
                    `Assoc
                      [
                        ( "1",
                          `Assoc
                            [
                              ( "name",
                                `String "keyword.operator.attribute.ocaml" );
                            ] );
                        ( "2",
                          `Assoc
                            [
                              ("name", `String "keyword.other.attribute.ocaml");
                              ( "patterns",
                                `List
                                  [
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "keyword.other.ocaml \
                                             punctuation.other.period \
                                             punctuation.separator.period" );
                                        ("match", `String "\\.");
                                      ];
                                  ] );
                            ] );
                      ] );
                  ("patterns", `List [ `Assoc [ ("include", `String "$self") ] ]);
                ] );
            ( "extensions",
              `Assoc
                [
                  ( "begin",
                    `String
                      "\\[(%|%%)[[:space:]]*([[:alpha:]_]+(\\.[[:word:]']+)*)"
                  );
                  ("end", `String "\\]");
                  ( "beginCaptures",
                    `Assoc
                      [
                        ( "1",
                          `Assoc
                            [
                              ( "name",
                                `String "keyword.operator.extension.ocaml" );
                            ] );
                        ( "2",
                          `Assoc
                            [
                              ("name", `String "keyword.other.extension.ocaml");
                              ( "patterns",
                                `List
                                  [
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "keyword.other.ocaml \
                                             punctuation.other.period \
                                             punctuation.separator.period" );
                                        ("match", `String "\\.");
                                      ];
                                  ] );
                            ] );
                      ] );
                  ("patterns", `List [ `Assoc [ ("include", `String "$self") ] ]);
                ] );
            ( "modules",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("begin", `String "\\b(sig)\\b");
                            ("end", `String "\\b(end)\\b");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                ] );
                            ( "endCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                ] );
                            ( "patterns",
                              `List
                                [
                                  `Assoc
                                    [
                                      ( "include",
                                        `String "source.ocaml.interface" );
                                    ];
                                ] );
                          ];
                        `Assoc
                          [
                            ("begin", `String "\\b(struct)\\b");
                            ("end", `String "\\b(end)\\b");
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                ] );
                            ( "endCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ("name", `String "keyword.other.ocaml");
                                      ] );
                                ] );
                            ( "patterns",
                              `List [ `Assoc [ ("include", `String "$self") ] ]
                            );
                          ];
                      ] );
                ] );
            ( "bindings",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "for loop");
                            ( "match",
                              `String
                                "\\b(for)[[:space:]]+([[:lower:]_][[:word:]']*)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "local open/exception/module");
                            ( "match",
                              `String
                                "\\b(let)[[:space:]]+(open|exception|module)\\b(?!')"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "let expression");
                            ( "match",
                              `String
                                "\\b(let)[[:space:]]+(?!lazy\\b(?!'))(rec[[:space:]]+)?(?!rec\\b(?!'))([[:lower:]_][[:word:]']*)(?![[:word:]'])[[:space:]]*(?!,|::|[[:space:]])"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "using binding operators");
                            ( "match",
                              `String
                                "\\b(let|and)([$&*+\\-/=>@^|<][!?$&*+\\-/=>@^|%:]*)[[:space:]]*(?!lazy\\b(?!'))([[:lower:]_][[:word:]']*)(?![[:word:]'])[[:space:]]*(?!,|::|[[:space:]])"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "first class module packing");
                            ( "match",
                              `String
                                "\\([[:space:]]*(val)[[:space:]]+([[:lower:]_][[:word:]']*)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "2",
                                    `Assoc
                                      [
                                        ( "patterns",
                                          `List
                                            [
                                              `Assoc
                                                [ ("include", `String "$self") ];
                                            ] );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ("comment", `String "locally abstract types");
                            ( "match",
                              `String
                                "(?:\\(|(:))[[:space:]]*(type)((?:[[:space:]]+[[:lower:]_][[:word:]']*)+)"
                            );
                            ( "captures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "keyword.other.ocaml \
                                             punctuation.other.colon \
                                             punctuation.colon" );
                                      ] );
                                  ( "2",
                                    `Assoc [ ("name", `String "keyword.ocaml") ]
                                  );
                                  ( "3",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "entity.name.function.binding.ocaml"
                                        );
                                      ] );
                                ] );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String "optional labeled argument with type" );
                            ( "begin",
                              `String
                                "(\\?)\\([[:space:]]*([[:lower:]_][[:word:]']*)"
                            );
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "variable.parameter.optional.ocaml"
                                        );
                                      ] );
                                  ( "2",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "variable.parameter.optional.ocaml"
                                        );
                                      ] );
                                ] );
                            ("end", `String "\\)");
                            ( "patterns",
                              `List [ `Assoc [ ("include", `String "$self") ] ]
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "labeled argument with type");
                            ( "begin",
                              `String
                                "(~)\\([[:space:]]*([[:lower:]_][[:word:]']*)"
                            );
                            ( "beginCaptures",
                              `Assoc
                                [
                                  ( "1",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "variable.parameter.labeled.ocaml"
                                        );
                                      ] );
                                  ( "2",
                                    `Assoc
                                      [
                                        ( "name",
                                          `String
                                            "variable.parameter.labeled.ocaml"
                                        );
                                      ] );
                                ] );
                            ("end", `String "\\)");
                            ( "patterns",
                              `List [ `Assoc [ ("include", `String "$self") ] ]
                            );
                          ];
                        `Assoc
                          [
                            ( "include",
                              `String "source.ocaml.interface#bindings" );
                          ];
                      ] );
                ] );
            ( "operators",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "binding operator");
                            ("name", `String "keyword.ocaml");
                            ( "match",
                              `String
                                "\\b(let|and)[$&*+\\-/=>@^|<][!?$&*+\\-/=>@^|%:]*"
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "infix symbol");
                            ("name", `String "keyword.operator.ocaml");
                            ( "match",
                              `String "[$&*+\\-/=>@^%<][~!?$&*+\\-/=>@^|%<:.]*"
                            );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "infix symbol that begins with vertical bar" );
                            ("name", `String "keyword.operator.ocaml");
                            ("match", `String "\\|[~!?$&*+\\-/=>@^|%<:.]+");
                          ];
                        `Assoc
                          [
                            ("comment", `String "vertical bar");
                            ("name", `String "keyword.other.ocaml");
                            ("match", `String "(?<!\\[)(\\|)(?!\\])");
                          ];
                        `Assoc
                          [
                            ("comment", `String "infix symbol");
                            ("name", `String "keyword.operator.ocaml");
                            ("match", `String "#[~!?$&*+\\-/=>@^|%<:.]+");
                          ];
                        `Assoc
                          [
                            ("comment", `String "prefix symbol");
                            ("name", `String "keyword.operator.ocaml");
                            ("match", `String "![~!?$&*+\\-/=>@^|%<:.]*");
                          ];
                        `Assoc
                          [
                            ("comment", `String "prefix symbol");
                            ("name", `String "keyword.operator.ocaml");
                            ("match", `String "[?~][~!?$&*+\\-/=>@^|%<:.]+");
                          ];
                        `Assoc
                          [
                            ("comment", `String "named operator");
                            ("name", `String "keyword.operator.ocaml");
                            ( "match",
                              `String "\\b(or|mod|land|lor|lxor|lsl|lsr|asr)\\b"
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "method invocation");
                            ("name", `String "keyword.other.ocaml");
                            ("match", `String "#");
                          ];
                        `Assoc
                          [
                            ("comment", `String "type annotation");
                            ( "name",
                              `String
                                "keyword.other.ocaml punctuation.other.colon \
                                 punctuation.colon" );
                            ("match", `String ":");
                          ];
                        `Assoc
                          [
                            ("comment", `String "field accessor");
                            ( "name",
                              `String
                                "keyword.other.ocaml punctuation.other.period \
                                 punctuation.separator.period" );
                            ("match", `String "\\.");
                          ];
                        `Assoc
                          [
                            ("comment", `String "semicolon separator");
                            ( "name",
                              `String
                                "keyword.other.ocaml \
                                 punctuation.separator.terminator \
                                 punctuation.separator.semicolon" );
                            ("match", `String ";");
                          ];
                        `Assoc
                          [
                            ("comment", `String "comma separator");
                            ( "name",
                              `String
                                "keyword.other.ocaml punctuation.comma \
                                 punctuation.separator.comma" );
                            ("match", `String ",");
                          ];
                      ] );
                ] );
            ( "keywords",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "reserved ocaml keyword");
                            ("name", `String "keyword.other.ocaml");
                            ( "match",
                              `String
                                "\\b(and|as|assert|begin|class|constraint|do|done|downto|else|end|exception|external|for|fun|function|functor|if|in|include|inherit|initializer|lazy|let|match|method|module|mutable|new|nonrec|object|of|open|private|rec|sig|struct|then|to|try|type|val|virtual|when|while|with)\\b(?!')"
                            );
                          ];
                      ] );
                ] );
            ( "literals",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "boolean literal");
                            ("name", `String "constant.language.boolean.ocaml");
                            ("match", `String "\\b(true|false)\\b");
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "floating point decimal literal with exponent"
                            );
                            ( "name",
                              `String "constant.numeric.decimal.float.ocaml" );
                            ( "match",
                              `String
                                "\\b([[:digit:]][[:digit:]_]*(\\.[[:digit:]_]*)?[eE][+-]?[[:digit:]][[:digit:]_]*[g-zG-Z]?)\\b"
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "floating point decimal literal");
                            ( "name",
                              `String "constant.numeric.decimal.float.ocaml" );
                            ( "match",
                              `String
                                "\\b([[:digit:]][[:digit:]_]*)(\\.[[:digit:]_]*[g-zG-Z]?\\b|\\.)"
                            );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "floating point hexadecimal literal with \
                                 exponent part" );
                            ( "name",
                              `String "constant.numeric.hexadecimal.float.ocaml"
                            );
                            ( "match",
                              `String
                                "\\b((0x|0X)[[:xdigit:]][[:xdigit:]_]*(\\.[[:xdigit:]_]*)?[pP][+-]?[[:digit:]][[:digit:]_]*[g-zG-Z]?)\\b"
                            );
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String "floating point hexadecimal literal" );
                            ( "name",
                              `String "constant.numeric.hexadecimal.float.ocaml"
                            );
                            ( "match",
                              `String
                                "\\b((0x|0X)[[:xdigit:]][[:xdigit:]_]*)(\\.[[:xdigit:]_]*[g-zG-Z]?\\b|\\.)"
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "decimal integer literal");
                            ( "name",
                              `String "constant.numeric.decimal.integer.ocaml"
                            );
                            ( "match",
                              `String
                                "\\b([[:digit:]][[:digit:]_]*[lLng-zG-Z]?)\\b"
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "hexadecimal integer literal");
                            ( "name",
                              `String
                                "constant.numeric.hexadecimal.integer.ocaml" );
                            ( "match",
                              `String
                                "\\b((0x|0X)[[:xdigit:]][[:xdigit:]_]*[lLng-zG-Z]?)\\b"
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "octal integer literal");
                            ( "name",
                              `String "constant.numeric.octal.integer.ocaml" );
                            ( "match",
                              `String "\\b((0o|0O)[0-7][0-7_]*[lLng-zG-Z]?)\\b"
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "binary integer literal");
                            ( "name",
                              `String "constant.numeric.binary.integer.ocaml" );
                            ( "match",
                              `String "\\b((0b|0B)[0-1][0-1_]*[lLng-zG-Z]?)\\b"
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "unit literal");
                            ("name", `String "constant.language.unit.ocaml");
                            ("match", `String "\\(\\)");
                          ];
                        `Assoc
                          [
                            ("comment", `String "parentheses");
                            ("begin", `String "\\(");
                            ("end", `String "\\)");
                            ( "patterns",
                              `List [ `Assoc [ ("include", `String "$self") ] ]
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "empty array");
                            ("name", `String "constant.language.array.ocaml");
                            ("match", `String "\\[\\|\\|\\]");
                          ];
                        `Assoc
                          [
                            ("comment", `String "array");
                            ("begin", `String "\\[\\|");
                            ("end", `String "\\|\\]");
                            ( "patterns",
                              `List [ `Assoc [ ("include", `String "$self") ] ]
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "empty list");
                            ("name", `String "constant.language.list.ocaml");
                            ("match", `String "\\[\\]");
                          ];
                        `Assoc
                          [
                            ("comment", `String "list");
                            ("begin", `String "\\[");
                            ("end", `String "]");
                            ( "patterns",
                              `List [ `Assoc [ ("include", `String "$self") ] ]
                            );
                          ];
                        `Assoc
                          [
                            ("comment", `String "braces");
                            ("begin", `String "\\{");
                            ("end", `String "\\}");
                            ( "patterns",
                              `List [ `Assoc [ ("include", `String "$self") ] ]
                            );
                          ];
                      ] );
                ] );
            ( "types",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "type parameter");
                            ("name", `String "storage.type.ocaml");
                            ( "match",
                              `String "'[[:alpha:]][[:word:]']*\\b|'_\\b" );
                          ];
                        `Assoc
                          [
                            ("comment", `String "weak type parameter");
                            ("name", `String "storage.type.weak.ocaml");
                            ("match", `String "'_[[:alpha:]][[:word:]']*\\b");
                          ];
                        `Assoc
                          [
                            ("comment", `String "builtin type");
                            ("name", `String "support.type.ocaml");
                            ( "match",
                              `String
                                "\\b(unit|bool|int|int32|int64|nativeint|float|char|bytes|string)\\b"
                            );
                          ];
                      ] );
                ] );
            ( "identifiers",
              `Assoc
                [
                  ( "patterns",
                    `List
                      [
                        `Assoc
                          [
                            ("comment", `String "wildcard underscore");
                            ("name", `String "constant.language.ocaml");
                            ("match", `String "\\b_\\b");
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "capital identifier for constructor, \
                                 exception, or module" );
                            ( "name",
                              `String
                                "constant.language.capital-identifier.ocaml" );
                            ( "match",
                              `String "\\b[[:upper:]][[:word:]']*('|\\b)" );
                          ];
                        `Assoc
                          [
                            ("comment", `String "lowercase identifier");
                            ("name", `String "source.ocaml");
                            ( "match",
                              `String "\\b[[:lower:]_][[:word:]']*('|\\b)" );
                          ];
                        `Assoc
                          [
                            ("comment", `String "polymorphic variant tag");
                            ( "name",
                              `String
                                "constant.language.polymorphic-variant.ocaml" );
                            ("match", `String "\\`[[:alpha:]][[:word:]']*\\b");
                          ];
                        `Assoc
                          [
                            ( "comment",
                              `String
                                "empty list (can be used as a constructor)" );
                            ("name", `String "constant.language.list.ocaml");
                            ("match", `String "\\[\\]");
                          ];
                      ] );
                ] );
          ] );
    ]
