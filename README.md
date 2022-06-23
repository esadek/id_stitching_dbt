# ID Stitching dbt Project

## Prerequisites

- [dbt Core](https://docs.getdbt.com/dbt-cli/install/overview)
- [Python 3](https://www.python.org/downloads/)

## Installation

Install dbt dependencies:

```bash
dbt deps
```

Install required Python packages:

```bash
pip install -r requirements.txt
```

Set profile in [dbt_project.yml](dbt_project.yml):

```yaml
profile: 'your_profile_name'
```

Set connection string in [run_models.py](run_models.py):

```python
db = create_engine("dialect+driver://username:password@host:port/database")
```

## Usage

Run models:

```bash
python run_scripts.py
```

## License

[MIT](LICENSE)