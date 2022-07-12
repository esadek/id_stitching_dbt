# ID Stitching dbt Project

## Prerequisites

- [dbt Core](https://docs.getdbt.com/dbt-cli/install/overview)
- [Python 3](https://www.python.org/downloads/)

## Installation

1. [Clone](https://github.com/git-guides/git-clone) repository:

    ```bash
    git clone https://github.com/esadek/id_stitching_dbt.git
    cd id_stitching_dbt
    ```

2. Install [dbt-utils](https://hub.getdbt.com/dbt-labs/dbt_utils/latest/):

    ```bash
    dbt deps
    ```

3. Install [SQLAlchemy](https://www.sqlalchemy.org/):

    ```bash
    pip install SQLAlchemy
    ```

4. Install appropriate [dialect and DBAPI driver](https://docs.sqlalchemy.org/en/14/dialects/index.html):

    ```bash
    pip install <dialect-package>
    ```

## Configuration

1. Set [profile](https://docs.getdbt.com/dbt-cli/configure-your-profile) and ID columns in [dbt_project.yml](dbt_project.yml):

    ```yaml
    profile: 'profile_name'
    ```

    ```yaml
    id-columns: ('anonymous_id', 'user_id', 'email')
    ```

2. Set [database URL](https://docs.sqlalchemy.org/en/14/core/engines.html?highlight=url#database-urls) in [run_models.py](run_models.py):

    ```python
    db = create_engine("dialect+driver://username:password@host:port/database")
    ```

## Usage

Run models:

```bash
python run_models.py
```

## License

[MIT](LICENSE)