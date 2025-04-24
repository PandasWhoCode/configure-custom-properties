# README for the project Configure Custom Properties

**Set and manage GitHub Organization-level Custom Properties via a simple custom_props.json config file.**

This action uses the GitHub CLI to apply property schemas automatically, making it easier to standardize
metadata across your repositories.

---

## 🚀 Getting Started

1. Create a custom_props.json file in the root of your repository (or another path).
2. Add this GitHub Action to your workflow.
3. Run the pipeline to apply the schema at the organization level.

---

## Fine Grained Token Requirements

To run the action within your github CI/CD pipeline you will need to create a
fine-grained token with the following permissions:

### Organization Permissions

- Read, Write, and Admin access to organization custom properties

### Additional Information

- [Create or update a custom property for an organization](https://docs.github.com/en/rest/orgs/custom-properties?apiVersion=2022-11-28#create-or-update-a-custom-property-for-an-organization)
- [Fine-grained personal access tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token)
- The owner of the fine-grained token must have full administrative rights to the organization.

---

## 📦 Inputs

| Name         | Description                                | Required | Default              |
|--------------|--------------------------------------------|----------|----------------------|
| `token`      | GitHub Personal Access Token (Fine-Grained with `Admin: write` org scope) | ✅ Yes    | —                    |
| `config-file`| Path to the custom properties config JSON  | ✅ Yes    | `custom_props.json`  |

---

## 🛠 Usage

```yaml
jobs:
  update-schema:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: pandaswhocode/configure-custom-properties@v1
        with:
          token: ${{ secrets.GH_ORG_ADMIN_TOKEN }}
          config-file: .github/custom_props.json
          organization: ${{ github.organization }}
```

---

## Example `.github/custom_props.json`

`custom_props.json`:

```json
{
  "properties": [
    {
      "property_name": "single_select_property",
      "value_type": "single_select",
      "allowed_values": [
        "option-1",
        "option-2",
        "option-3",
        "option-4"
      ],
      "description": "Default single select property",
      "values_editable_by": "org_and_repo_actors",
      "required": false
    },
    {
      "property_name": "multi_select_property",
      "value_type": "multi_select",
      "allowed_values": [
        "option-1",
        "option-2",
        "option-3",
        "option-4"
      ],
      "description": "Default multi select property",
      "values_editable_by": "org_and_repo_actors",
      "required": false
    },
    {
      "property_name": "text_property",
      "value_type": "string",
      "description": "Default 'text' property type",
      "values_editable_by": "org_and_repo_actors",
      "required": false
    },
    {
      "property_name": "bool_test",
      "value_type": "true_false",
      "description": "Default true-false property type",
      "values_editable_by": "org_and_repo_actors",
      "required": false
    }
  ]
}
```

For help generating your `custom-props.json` file see the documentation for our tool [generate-custom-properties](https://github.com/PandasWhoCode/generate-custom-properties-schema).

## 👤 Author

Roger Barker

[PandasWhoCode](https://pandaswhocode.com)

[roger@pandaswhocode.com](mailto:roger@pandaswhocode.com)

---