ENV["JULIA_PKG_USE_CLI_GIT"] = true

import Pkg
let
    pkgs = ["Revise", "OhMyREPL", "LanguageServer"]
    for pkg in pkgs
        if Base.find_package(pkg) === nothing
            Pkg.add(pkg)
        end
    end
end

using Revise
using OhMyREPL
@async begin
    while !isdefined(Base, :active_repl)
        sleep(0.1)
    end
    OhMyREPL.Prompt.insert_keybindings()
end
OhMyREPL.input_prompt!("λ ", :green)
OhMyREPL.enable_autocomplete_brackets(false)
