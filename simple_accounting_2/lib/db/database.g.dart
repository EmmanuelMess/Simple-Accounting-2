// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AccountRowDao _accountRowDaoInstance;

  MonthDao _monthDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AccountRow` (`id` INTEGER, `position` INTEGER, `date` TEXT, `reference` TEXT, `credit` TEXT, `debit` TEXT, `month_id` INTEGER, `currency` TEXT, FOREIGN KEY (`month_id`) REFERENCES `Month` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Month` (`id` INTEGER, `month` INTEGER, `year` INTEGER, `currency` TEXT, `balance` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AccountRowDao get accountRowDao {
    return _accountRowDaoInstance ??= _$AccountRowDao(database, changeListener);
  }

  @override
  MonthDao get monthDao {
    return _monthDaoInstance ??= _$MonthDao(database, changeListener);
  }
}

class _$AccountRowDao extends AccountRowDao {
  _$AccountRowDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _accountRowInsertionAdapter = InsertionAdapter(
            database,
            'AccountRow',
            (AccountRow item) => <String, dynamic>{
                  'id': item.id,
                  'position': item.position,
                  'date': item.date,
                  'reference': item.reference,
                  'credit': item.credit,
                  'debit': item.debit,
                  'month_id': item.monthId,
                  'currency': item.currency
                },
            changeListener),
        _accountRowUpdateAdapter = UpdateAdapter(
            database,
            'AccountRow',
            ['id'],
            (AccountRow item) => <String, dynamic>{
                  'id': item.id,
                  'position': item.position,
                  'date': item.date,
                  'reference': item.reference,
                  'credit': item.credit,
                  'debit': item.debit,
                  'month_id': item.monthId,
                  'currency': item.currency
                },
            changeListener),
        _accountRowDeletionAdapter = DeletionAdapter(
            database,
            'AccountRow',
            ['id'],
            (AccountRow item) => <String, dynamic>{
                  'id': item.id,
                  'position': item.position,
                  'date': item.date,
                  'reference': item.reference,
                  'credit': item.credit,
                  'debit': item.debit,
                  'month_id': item.monthId,
                  'currency': item.currency
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _accountRowMapper = (Map<String, dynamic> row) => AccountRow(
      row['id'] as int,
      row['position'] as int,
      row['date'] as String,
      row['reference'] as String,
      row['credit'] as String,
      row['debit'] as String,
      row['month_id'] as int,
      row['currency'] as String);

  final InsertionAdapter<AccountRow> _accountRowInsertionAdapter;

  final UpdateAdapter<AccountRow> _accountRowUpdateAdapter;

  final DeletionAdapter<AccountRow> _accountRowDeletionAdapter;

  @override
  Stream<List<AccountRow>> findAllAccountRowsAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM AccountRow ORDER BY AccountRow.position ASC',
        queryableName: 'AccountRow',
        isView: false,
        mapper: _accountRowMapper);
  }

  @override
  Future<void> insertAccountRow(AccountRow accountRow) async {
    await _accountRowInsertionAdapter.insert(
        accountRow, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAccountRow(AccountRow accountRow) async {
    await _accountRowUpdateAdapter.update(accountRow, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAccountRowById(AccountRow accountRow) async {
    await _accountRowDeletionAdapter.delete(accountRow);
  }
}

class _$MonthDao extends MonthDao {
  _$MonthDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _monthInsertionAdapter = InsertionAdapter(
            database,
            'Month',
            (Month item) => <String, dynamic>{
                  'id': item.id,
                  'month': item.month,
                  'year': item.year,
                  'currency': item.currency,
                  'balance': item.balance
                },
            changeListener),
        _monthUpdateAdapter = UpdateAdapter(
            database,
            'Month',
            ['id'],
            (Month item) => <String, dynamic>{
                  'id': item.id,
                  'month': item.month,
                  'year': item.year,
                  'currency': item.currency,
                  'balance': item.balance
                },
            changeListener),
        _monthDeletionAdapter = DeletionAdapter(
            database,
            'Month',
            ['id'],
            (Month item) => <String, dynamic>{
                  'id': item.id,
                  'month': item.month,
                  'year': item.year,
                  'currency': item.currency,
                  'balance': item.balance
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _monthMapper = (Map<String, dynamic> row) => Month(
      row['id'] as int,
      row['month'] as int,
      row['year'] as int,
      row['currency'] as String,
      row['balance'] as String);

  final InsertionAdapter<Month> _monthInsertionAdapter;

  final UpdateAdapter<Month> _monthUpdateAdapter;

  final DeletionAdapter<Month> _monthDeletionAdapter;

  @override
  Stream<List<Month>> findAllMonthsAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Month ORDER BY Month.month ASC',
        queryableName: 'Month',
        isView: false,
        mapper: _monthMapper);
  }

  @override
  Future<void> insertMonth(Month accountRow) async {
    await _monthInsertionAdapter.insert(accountRow, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMonth(Month accountRow) async {
    await _monthUpdateAdapter.update(accountRow, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMonthById(Month accountRow) async {
    await _monthDeletionAdapter.delete(accountRow);
  }
}
