# project-template

A copier template that gives every new project the same workflow, whatever the language.

## Create a project

```sh
uvx copier copy --trust gh:gnantel/project-template my-project
```

The `--trust` flag is needed because the template runs a task (the initial git commit). Copier asks for the project name, description, language (`python`, `typescript`,
`rust`, `java`), project kind (`library`, `application`, `service`) and, for Java,
whether to use Spring Boot. To skip the questions, pass answers with `--data`:

```sh
uvx copier copy --trust --defaults \
  --data project_name=demo --data project_description="A demo" \
  --data language=python --data project_kind=library \
  gh:gnantel/project-template my-project
```

The new directory is a git repository on `main` with one initial commit. Its
`.copier-answers.yml` records your answers; keep it committed.

## Day-to-day commands

Every project has a `justfile` with the same entry points, whatever the language:
`just fmt`, `just lint` (check only), `just test` and `just check` (lint + test).
Variants add `just dev` when the project has something to run. Run `just --list`
to see what a project offers.

## Git hooks

Python projects get [lefthook](https://github.com/evilmartians/lefthook) hooks,
installed when the project is generated (`uv run lefthook install`). Before each
commit the staged `.py` files are formatted and linted, and fixes are re-staged. Before each push,
pyright and pytest must pass. After cloning a project, run `uv run lefthook install` again.

## Claude Code setup

Generated projects include `.claude/settings.json`: a permission allowlist for the project's tooling and read-only git, a hook that formats each file Claude edits, and a hook that runs `just lint` before Claude finishes a turn. Services also enable `operational-readiness@personal` and get a `.claude/operational.md` stub; Spring Boot projects enable `spring-boot@personal`. The hooks need `jq`, and so far only the Python variant has a formatter and the lint check wired into the hooks. A `CLAUDE.md` skeleton lists the commands and layout. Both plugins come from the `personal` marketplace, which must be installed on your machine.

## Publish it on GitHub

The template already creates the `main` branch, so only the remote is left. From
the project directory, create the GitHub repository, add it as `origin` and push
`main` in one step:

```sh
gh repo create <owner>/my-project --private --source . --remote origin --push
```

GitHub makes the first pushed branch the default, so `main` becomes the default
branch. If the repository already exists and is empty, add the remote and push
instead:

```sh
git remote add origin git@github.com:<owner>/my-project.git
git push -u origin main
```

## Update a project

From the project directory, with a clean working tree:

```sh
uvx copier update --trust
```

Copier re-applies the template's changes since the version the project was
generated from, using the saved answers. Review and commit the result.
