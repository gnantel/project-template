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

## Update a project

From the project directory, with a clean working tree:

```sh
uvx copier update --trust
```

Copier re-applies the template's changes since the version the project was
generated from, using the saved answers. Review and commit the result.
