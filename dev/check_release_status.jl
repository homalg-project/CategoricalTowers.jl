#!/usr/bin/env julia
#
# For each package in this monorepo, compares the version in its Project.toml
# against the latest version registered in the Julia General registry, and
# writes a shields.io endpoint badge JSON file to dev/badges/<PackageName>.json.
#
# This is used by .github/workflows/release-status.yml to keep the README
# badges up to date, so that it becomes obvious when someone forgot to
# trigger @JuliaRegistrator after bumping a version.

import Pkg
using TOML

const PACKAGES = [
    "ToolsForCategoricalTowers",
    "QuotientCategories",
    "FpCategories",
    "FpLinearCategories",
    "Locales",
    "SubcategoriesForCAP",
    "PresheafCategories",
    "FiniteCocompletions",
    "FunctorCategories",
]

const BADGES_DIR = joinpath(@__DIR__, "badges")

function local_version(pkg::AbstractString)
    project = TOML.parsefile(joinpath(@__DIR__, "..", pkg, "Project.toml"))
    return VersionNumber(project["version"])
end

function latest_registered_version(pkg::AbstractString)
    general = only(filter(r -> r.name == "General", Pkg.Registry.reachable_registries()))

    entry = nothing
    for e in values(general.pkgs)
        if e.name == pkg
            entry = e
            break
        end
    end
    entry === nothing && return nothing

    version_info = Pkg.Registry.registry_info(entry).version_info
    non_yanked = [v for (v, info) in version_info if !info.yanked]
    isempty(non_yanked) && return nothing

    return maximum(non_yanked)
end

function badge_json(; label::AbstractString, message::AbstractString, color::AbstractString)
    escape(s) = replace(s, "\"" => "\\\"")
    return """
    {"schemaVersion":1,"label":"$(escape(label))","message":"$(escape(message))","color":"$(escape(color))"}
    """
end

function status_badge(pkg::AbstractString)
    local_v = local_version(pkg)
    latest_v = latest_registered_version(pkg)

    if latest_v === nothing
        return badge_json(label = "release", message = "v$(local_v) never registered", color = "lightgrey")
    elseif local_v == latest_v
        return badge_json(label = "release", message = "v$(local_v) released", color = "brightgreen")
    elseif local_v > latest_v
        return badge_json(label = "release", message = "v$(local_v) NOT released (latest: v$(latest_v))", color = "red")
    else
        return badge_json(label = "release", message = "v$(local_v) (registry has v$(latest_v))", color = "orange")
    end
end

function main()
    isempty(Pkg.Registry.reachable_registries()) && Pkg.Registry.add("General")
    Pkg.Registry.update()

    mkpath(BADGES_DIR)

    for pkg in PACKAGES
        json = status_badge(pkg)
        path = joinpath(BADGES_DIR, "$(pkg).json")
        write(path, json)
        println("Wrote $(path):\n$(json)")
    end
end

main()
