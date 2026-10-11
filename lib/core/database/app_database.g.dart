// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StudentProfilesTable extends StudentProfiles
    with TableInfo<$StudentProfilesTable, StudentProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyLevelMeta = const VerificationMeta(
    'studyLevel',
  );
  @override
  late final GeneratedColumn<String> studyLevel = GeneratedColumn<String>(
    'study_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _institutionMeta = const VerificationMeta(
    'institution',
  );
  @override
  late final GeneratedColumn<String> institution = GeneratedColumn<String>(
    'institution',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _academicYearMeta = const VerificationMeta(
    'academicYear',
  );
  @override
  late final GeneratedColumn<String> academicYear = GeneratedColumn<String>(
    'academic_year',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preferredLanguageMeta = const VerificationMeta(
    'preferredLanguage',
  );
  @override
  late final GeneratedColumn<String> preferredLanguage =
      GeneratedColumn<String>(
        'preferred_language',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    studyLevel,
    institution,
    academicYear,
    preferredLanguage,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('study_level')) {
      context.handle(
        _studyLevelMeta,
        studyLevel.isAcceptableOrUnknown(data['study_level']!, _studyLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_studyLevelMeta);
    }
    if (data.containsKey('institution')) {
      context.handle(
        _institutionMeta,
        institution.isAcceptableOrUnknown(
          data['institution']!,
          _institutionMeta,
        ),
      );
    }
    if (data.containsKey('academic_year')) {
      context.handle(
        _academicYearMeta,
        academicYear.isAcceptableOrUnknown(
          data['academic_year']!,
          _academicYearMeta,
        ),
      );
    }
    if (data.containsKey('preferred_language')) {
      context.handle(
        _preferredLanguageMeta,
        preferredLanguage.isAcceptableOrUnknown(
          data['preferred_language']!,
          _preferredLanguageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preferredLanguageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      studyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_level'],
      )!,
      institution: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}institution'],
      ),
      academicYear: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}academic_year'],
      ),
      preferredLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_language'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudentProfilesTable createAlias(String alias) {
    return $StudentProfilesTable(attachedDatabase, alias);
  }
}

class StudentProfileRow extends DataClass
    implements Insertable<StudentProfileRow> {
  final String id;
  final String displayName;
  final String studyLevel;
  final String? institution;
  final String? academicYear;
  final String preferredLanguage;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StudentProfileRow({
    required this.id,
    required this.displayName,
    required this.studyLevel,
    this.institution,
    this.academicYear,
    required this.preferredLanguage,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    map['study_level'] = Variable<String>(studyLevel);
    if (!nullToAbsent || institution != null) {
      map['institution'] = Variable<String>(institution);
    }
    if (!nullToAbsent || academicYear != null) {
      map['academic_year'] = Variable<String>(academicYear);
    }
    map['preferred_language'] = Variable<String>(preferredLanguage);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudentProfilesCompanion toCompanion(bool nullToAbsent) {
    return StudentProfilesCompanion(
      id: Value(id),
      displayName: Value(displayName),
      studyLevel: Value(studyLevel),
      institution: institution == null && nullToAbsent
          ? const Value.absent()
          : Value(institution),
      academicYear: academicYear == null && nullToAbsent
          ? const Value.absent()
          : Value(academicYear),
      preferredLanguage: Value(preferredLanguage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudentProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentProfileRow(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      studyLevel: serializer.fromJson<String>(json['studyLevel']),
      institution: serializer.fromJson<String?>(json['institution']),
      academicYear: serializer.fromJson<String?>(json['academicYear']),
      preferredLanguage: serializer.fromJson<String>(json['preferredLanguage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'studyLevel': serializer.toJson<String>(studyLevel),
      'institution': serializer.toJson<String?>(institution),
      'academicYear': serializer.toJson<String?>(academicYear),
      'preferredLanguage': serializer.toJson<String>(preferredLanguage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StudentProfileRow copyWith({
    String? id,
    String? displayName,
    String? studyLevel,
    Value<String?> institution = const Value.absent(),
    Value<String?> academicYear = const Value.absent(),
    String? preferredLanguage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => StudentProfileRow(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    studyLevel: studyLevel ?? this.studyLevel,
    institution: institution.present ? institution.value : this.institution,
    academicYear: academicYear.present ? academicYear.value : this.academicYear,
    preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StudentProfileRow copyWithCompanion(StudentProfilesCompanion data) {
    return StudentProfileRow(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      studyLevel: data.studyLevel.present
          ? data.studyLevel.value
          : this.studyLevel,
      institution: data.institution.present
          ? data.institution.value
          : this.institution,
      academicYear: data.academicYear.present
          ? data.academicYear.value
          : this.academicYear,
      preferredLanguage: data.preferredLanguage.present
          ? data.preferredLanguage.value
          : this.preferredLanguage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfileRow(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('studyLevel: $studyLevel, ')
          ..write('institution: $institution, ')
          ..write('academicYear: $academicYear, ')
          ..write('preferredLanguage: $preferredLanguage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    studyLevel,
    institution,
    academicYear,
    preferredLanguage,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentProfileRow &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.studyLevel == this.studyLevel &&
          other.institution == this.institution &&
          other.academicYear == this.academicYear &&
          other.preferredLanguage == this.preferredLanguage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudentProfilesCompanion extends UpdateCompanion<StudentProfileRow> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<String> studyLevel;
  final Value<String?> institution;
  final Value<String?> academicYear;
  final Value<String> preferredLanguage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StudentProfilesCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.studyLevel = const Value.absent(),
    this.institution = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.preferredLanguage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentProfilesCompanion.insert({
    required String id,
    required String displayName,
    required String studyLevel,
    this.institution = const Value.absent(),
    this.academicYear = const Value.absent(),
    required String preferredLanguage,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName),
       studyLevel = Value(studyLevel),
       preferredLanguage = Value(preferredLanguage),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<StudentProfileRow> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? studyLevel,
    Expression<String>? institution,
    Expression<String>? academicYear,
    Expression<String>? preferredLanguage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (studyLevel != null) 'study_level': studyLevel,
      if (institution != null) 'institution': institution,
      if (academicYear != null) 'academic_year': academicYear,
      if (preferredLanguage != null) 'preferred_language': preferredLanguage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<String>? studyLevel,
    Value<String?>? institution,
    Value<String?>? academicYear,
    Value<String>? preferredLanguage,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return StudentProfilesCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      studyLevel: studyLevel ?? this.studyLevel,
      institution: institution ?? this.institution,
      academicYear: academicYear ?? this.academicYear,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (studyLevel.present) {
      map['study_level'] = Variable<String>(studyLevel.value);
    }
    if (institution.present) {
      map['institution'] = Variable<String>(institution.value);
    }
    if (academicYear.present) {
      map['academic_year'] = Variable<String>(academicYear.value);
    }
    if (preferredLanguage.present) {
      map['preferred_language'] = Variable<String>(preferredLanguage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfilesCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('studyLevel: $studyLevel, ')
          ..write('institution: $institution, ')
          ..write('academicYear: $academicYear, ')
          ..write('preferredLanguage: $preferredLanguage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyPlansTable extends StudyPlans
    with TableInfo<$StudyPlansTable, StudyPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _planTypeMeta = const VerificationMeta(
    'planType',
  );
  @override
  late final GeneratedColumn<String> planType = GeneratedColumn<String>(
    'plan_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetEndDateMeta = const VerificationMeta(
    'targetEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetEndDate =
      GeneratedColumn<DateTime>(
        'target_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _primaryExamIdMeta = const VerificationMeta(
    'primaryExamId',
  );
  @override
  late final GeneratedColumn<String> primaryExamId = GeneratedColumn<String>(
    'primary_exam_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _planningModeMeta = const VerificationMeta(
    'planningMode',
  );
  @override
  late final GeneratedColumn<String> planningMode = GeneratedColumn<String>(
    'planning_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dailyIntensityMeta = const VerificationMeta(
    'dailyIntensity',
  );
  @override
  late final GeneratedColumn<String> dailyIntensity = GeneratedColumn<String>(
    'daily_intensity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxDailyMinutesMeta = const VerificationMeta(
    'maxDailyMinutes',
  );
  @override
  late final GeneratedColumn<int> maxDailyMinutes = GeneratedColumn<int>(
    'max_daily_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxSessionMinutesMeta = const VerificationMeta(
    'maxSessionMinutes',
  );
  @override
  late final GeneratedColumn<int> maxSessionMinutes = GeneratedColumn<int>(
    'max_session_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planningBufferPercentMeta =
      const VerificationMeta('planningBufferPercent');
  @override
  late final GeneratedColumn<int> planningBufferPercent = GeneratedColumn<int>(
    'planning_buffer_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revisionBufferDaysMeta =
      const VerificationMeta('revisionBufferDays');
  @override
  late final GeneratedColumn<int> revisionBufferDays = GeneratedColumn<int>(
    'revision_buffer_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    planType,
    status,
    startDate,
    targetEndDate,
    primaryExamId,
    planningMode,
    dailyIntensity,
    maxDailyMinutes,
    maxSessionMinutes,
    planningBufferPercent,
    revisionBufferDays,
    createdAt,
    updatedAt,
    archivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyPlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('plan_type')) {
      context.handle(
        _planTypeMeta,
        planType.isAcceptableOrUnknown(data['plan_type']!, _planTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_planTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('target_end_date')) {
      context.handle(
        _targetEndDateMeta,
        targetEndDate.isAcceptableOrUnknown(
          data['target_end_date']!,
          _targetEndDateMeta,
        ),
      );
    }
    if (data.containsKey('primary_exam_id')) {
      context.handle(
        _primaryExamIdMeta,
        primaryExamId.isAcceptableOrUnknown(
          data['primary_exam_id']!,
          _primaryExamIdMeta,
        ),
      );
    }
    if (data.containsKey('planning_mode')) {
      context.handle(
        _planningModeMeta,
        planningMode.isAcceptableOrUnknown(
          data['planning_mode']!,
          _planningModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_planningModeMeta);
    }
    if (data.containsKey('daily_intensity')) {
      context.handle(
        _dailyIntensityMeta,
        dailyIntensity.isAcceptableOrUnknown(
          data['daily_intensity']!,
          _dailyIntensityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyIntensityMeta);
    }
    if (data.containsKey('max_daily_minutes')) {
      context.handle(
        _maxDailyMinutesMeta,
        maxDailyMinutes.isAcceptableOrUnknown(
          data['max_daily_minutes']!,
          _maxDailyMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxDailyMinutesMeta);
    }
    if (data.containsKey('max_session_minutes')) {
      context.handle(
        _maxSessionMinutesMeta,
        maxSessionMinutes.isAcceptableOrUnknown(
          data['max_session_minutes']!,
          _maxSessionMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxSessionMinutesMeta);
    }
    if (data.containsKey('planning_buffer_percent')) {
      context.handle(
        _planningBufferPercentMeta,
        planningBufferPercent.isAcceptableOrUnknown(
          data['planning_buffer_percent']!,
          _planningBufferPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_planningBufferPercentMeta);
    }
    if (data.containsKey('revision_buffer_days')) {
      context.handle(
        _revisionBufferDaysMeta,
        revisionBufferDays.isAcceptableOrUnknown(
          data['revision_buffer_days']!,
          _revisionBufferDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_revisionBufferDaysMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyPlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      planType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      targetEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_end_date'],
      ),
      primaryExamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_exam_id'],
      ),
      planningMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}planning_mode'],
      )!,
      dailyIntensity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}daily_intensity'],
      )!,
      maxDailyMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_daily_minutes'],
      )!,
      maxSessionMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_session_minutes'],
      )!,
      planningBufferPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planning_buffer_percent'],
      )!,
      revisionBufferDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision_buffer_days'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
    );
  }

  @override
  $StudyPlansTable createAlias(String alias) {
    return $StudyPlansTable(attachedDatabase, alias);
  }
}

class StudyPlanRow extends DataClass implements Insertable<StudyPlanRow> {
  final String id;
  final String name;
  final String? description;
  final String planType;
  final String status;
  final DateTime startDate;
  final DateTime? targetEndDate;

  /// Plain id. A foreign key would cycle with [Exams.studyPlanId].
  final String? primaryExamId;
  final String planningMode;
  final String dailyIntensity;
  final int maxDailyMinutes;
  final int maxSessionMinutes;
  final int planningBufferPercent;
  final int revisionBufferDays;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;
  const StudyPlanRow({
    required this.id,
    required this.name,
    this.description,
    required this.planType,
    required this.status,
    required this.startDate,
    this.targetEndDate,
    this.primaryExamId,
    required this.planningMode,
    required this.dailyIntensity,
    required this.maxDailyMinutes,
    required this.maxSessionMinutes,
    required this.planningBufferPercent,
    required this.revisionBufferDays,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['plan_type'] = Variable<String>(planType);
    map['status'] = Variable<String>(status);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || targetEndDate != null) {
      map['target_end_date'] = Variable<DateTime>(targetEndDate);
    }
    if (!nullToAbsent || primaryExamId != null) {
      map['primary_exam_id'] = Variable<String>(primaryExamId);
    }
    map['planning_mode'] = Variable<String>(planningMode);
    map['daily_intensity'] = Variable<String>(dailyIntensity);
    map['max_daily_minutes'] = Variable<int>(maxDailyMinutes);
    map['max_session_minutes'] = Variable<int>(maxSessionMinutes);
    map['planning_buffer_percent'] = Variable<int>(planningBufferPercent);
    map['revision_buffer_days'] = Variable<int>(revisionBufferDays);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    return map;
  }

  StudyPlansCompanion toCompanion(bool nullToAbsent) {
    return StudyPlansCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      planType: Value(planType),
      status: Value(status),
      startDate: Value(startDate),
      targetEndDate: targetEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetEndDate),
      primaryExamId: primaryExamId == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryExamId),
      planningMode: Value(planningMode),
      dailyIntensity: Value(dailyIntensity),
      maxDailyMinutes: Value(maxDailyMinutes),
      maxSessionMinutes: Value(maxSessionMinutes),
      planningBufferPercent: Value(planningBufferPercent),
      revisionBufferDays: Value(revisionBufferDays),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory StudyPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyPlanRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      planType: serializer.fromJson<String>(json['planType']),
      status: serializer.fromJson<String>(json['status']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      targetEndDate: serializer.fromJson<DateTime?>(json['targetEndDate']),
      primaryExamId: serializer.fromJson<String?>(json['primaryExamId']),
      planningMode: serializer.fromJson<String>(json['planningMode']),
      dailyIntensity: serializer.fromJson<String>(json['dailyIntensity']),
      maxDailyMinutes: serializer.fromJson<int>(json['maxDailyMinutes']),
      maxSessionMinutes: serializer.fromJson<int>(json['maxSessionMinutes']),
      planningBufferPercent: serializer.fromJson<int>(
        json['planningBufferPercent'],
      ),
      revisionBufferDays: serializer.fromJson<int>(json['revisionBufferDays']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'planType': serializer.toJson<String>(planType),
      'status': serializer.toJson<String>(status),
      'startDate': serializer.toJson<DateTime>(startDate),
      'targetEndDate': serializer.toJson<DateTime?>(targetEndDate),
      'primaryExamId': serializer.toJson<String?>(primaryExamId),
      'planningMode': serializer.toJson<String>(planningMode),
      'dailyIntensity': serializer.toJson<String>(dailyIntensity),
      'maxDailyMinutes': serializer.toJson<int>(maxDailyMinutes),
      'maxSessionMinutes': serializer.toJson<int>(maxSessionMinutes),
      'planningBufferPercent': serializer.toJson<int>(planningBufferPercent),
      'revisionBufferDays': serializer.toJson<int>(revisionBufferDays),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
    };
  }

  StudyPlanRow copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? planType,
    String? status,
    DateTime? startDate,
    Value<DateTime?> targetEndDate = const Value.absent(),
    Value<String?> primaryExamId = const Value.absent(),
    String? planningMode,
    String? dailyIntensity,
    int? maxDailyMinutes,
    int? maxSessionMinutes,
    int? planningBufferPercent,
    int? revisionBufferDays,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> archivedAt = const Value.absent(),
  }) => StudyPlanRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    planType: planType ?? this.planType,
    status: status ?? this.status,
    startDate: startDate ?? this.startDate,
    targetEndDate: targetEndDate.present
        ? targetEndDate.value
        : this.targetEndDate,
    primaryExamId: primaryExamId.present
        ? primaryExamId.value
        : this.primaryExamId,
    planningMode: planningMode ?? this.planningMode,
    dailyIntensity: dailyIntensity ?? this.dailyIntensity,
    maxDailyMinutes: maxDailyMinutes ?? this.maxDailyMinutes,
    maxSessionMinutes: maxSessionMinutes ?? this.maxSessionMinutes,
    planningBufferPercent: planningBufferPercent ?? this.planningBufferPercent,
    revisionBufferDays: revisionBufferDays ?? this.revisionBufferDays,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
  );
  StudyPlanRow copyWithCompanion(StudyPlansCompanion data) {
    return StudyPlanRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      planType: data.planType.present ? data.planType.value : this.planType,
      status: data.status.present ? data.status.value : this.status,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      targetEndDate: data.targetEndDate.present
          ? data.targetEndDate.value
          : this.targetEndDate,
      primaryExamId: data.primaryExamId.present
          ? data.primaryExamId.value
          : this.primaryExamId,
      planningMode: data.planningMode.present
          ? data.planningMode.value
          : this.planningMode,
      dailyIntensity: data.dailyIntensity.present
          ? data.dailyIntensity.value
          : this.dailyIntensity,
      maxDailyMinutes: data.maxDailyMinutes.present
          ? data.maxDailyMinutes.value
          : this.maxDailyMinutes,
      maxSessionMinutes: data.maxSessionMinutes.present
          ? data.maxSessionMinutes.value
          : this.maxSessionMinutes,
      planningBufferPercent: data.planningBufferPercent.present
          ? data.planningBufferPercent.value
          : this.planningBufferPercent,
      revisionBufferDays: data.revisionBufferDays.present
          ? data.revisionBufferDays.value
          : this.revisionBufferDays,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyPlanRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('planType: $planType, ')
          ..write('status: $status, ')
          ..write('startDate: $startDate, ')
          ..write('targetEndDate: $targetEndDate, ')
          ..write('primaryExamId: $primaryExamId, ')
          ..write('planningMode: $planningMode, ')
          ..write('dailyIntensity: $dailyIntensity, ')
          ..write('maxDailyMinutes: $maxDailyMinutes, ')
          ..write('maxSessionMinutes: $maxSessionMinutes, ')
          ..write('planningBufferPercent: $planningBufferPercent, ')
          ..write('revisionBufferDays: $revisionBufferDays, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    planType,
    status,
    startDate,
    targetEndDate,
    primaryExamId,
    planningMode,
    dailyIntensity,
    maxDailyMinutes,
    maxSessionMinutes,
    planningBufferPercent,
    revisionBufferDays,
    createdAt,
    updatedAt,
    archivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyPlanRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.planType == this.planType &&
          other.status == this.status &&
          other.startDate == this.startDate &&
          other.targetEndDate == this.targetEndDate &&
          other.primaryExamId == this.primaryExamId &&
          other.planningMode == this.planningMode &&
          other.dailyIntensity == this.dailyIntensity &&
          other.maxDailyMinutes == this.maxDailyMinutes &&
          other.maxSessionMinutes == this.maxSessionMinutes &&
          other.planningBufferPercent == this.planningBufferPercent &&
          other.revisionBufferDays == this.revisionBufferDays &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.archivedAt == this.archivedAt);
}

class StudyPlansCompanion extends UpdateCompanion<StudyPlanRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> planType;
  final Value<String> status;
  final Value<DateTime> startDate;
  final Value<DateTime?> targetEndDate;
  final Value<String?> primaryExamId;
  final Value<String> planningMode;
  final Value<String> dailyIntensity;
  final Value<int> maxDailyMinutes;
  final Value<int> maxSessionMinutes;
  final Value<int> planningBufferPercent;
  final Value<int> revisionBufferDays;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> archivedAt;
  final Value<int> rowid;
  const StudyPlansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.planType = const Value.absent(),
    this.status = const Value.absent(),
    this.startDate = const Value.absent(),
    this.targetEndDate = const Value.absent(),
    this.primaryExamId = const Value.absent(),
    this.planningMode = const Value.absent(),
    this.dailyIntensity = const Value.absent(),
    this.maxDailyMinutes = const Value.absent(),
    this.maxSessionMinutes = const Value.absent(),
    this.planningBufferPercent = const Value.absent(),
    this.revisionBufferDays = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyPlansCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required String planType,
    required String status,
    required DateTime startDate,
    this.targetEndDate = const Value.absent(),
    this.primaryExamId = const Value.absent(),
    required String planningMode,
    required String dailyIntensity,
    required int maxDailyMinutes,
    required int maxSessionMinutes,
    required int planningBufferPercent,
    required int revisionBufferDays,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       planType = Value(planType),
       status = Value(status),
       startDate = Value(startDate),
       planningMode = Value(planningMode),
       dailyIntensity = Value(dailyIntensity),
       maxDailyMinutes = Value(maxDailyMinutes),
       maxSessionMinutes = Value(maxSessionMinutes),
       planningBufferPercent = Value(planningBufferPercent),
       revisionBufferDays = Value(revisionBufferDays),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<StudyPlanRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? planType,
    Expression<String>? status,
    Expression<DateTime>? startDate,
    Expression<DateTime>? targetEndDate,
    Expression<String>? primaryExamId,
    Expression<String>? planningMode,
    Expression<String>? dailyIntensity,
    Expression<int>? maxDailyMinutes,
    Expression<int>? maxSessionMinutes,
    Expression<int>? planningBufferPercent,
    Expression<int>? revisionBufferDays,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? archivedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (planType != null) 'plan_type': planType,
      if (status != null) 'status': status,
      if (startDate != null) 'start_date': startDate,
      if (targetEndDate != null) 'target_end_date': targetEndDate,
      if (primaryExamId != null) 'primary_exam_id': primaryExamId,
      if (planningMode != null) 'planning_mode': planningMode,
      if (dailyIntensity != null) 'daily_intensity': dailyIntensity,
      if (maxDailyMinutes != null) 'max_daily_minutes': maxDailyMinutes,
      if (maxSessionMinutes != null) 'max_session_minutes': maxSessionMinutes,
      if (planningBufferPercent != null)
        'planning_buffer_percent': planningBufferPercent,
      if (revisionBufferDays != null)
        'revision_buffer_days': revisionBufferDays,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyPlansCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? planType,
    Value<String>? status,
    Value<DateTime>? startDate,
    Value<DateTime?>? targetEndDate,
    Value<String?>? primaryExamId,
    Value<String>? planningMode,
    Value<String>? dailyIntensity,
    Value<int>? maxDailyMinutes,
    Value<int>? maxSessionMinutes,
    Value<int>? planningBufferPercent,
    Value<int>? revisionBufferDays,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? archivedAt,
    Value<int>? rowid,
  }) {
    return StudyPlansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      planType: planType ?? this.planType,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      targetEndDate: targetEndDate ?? this.targetEndDate,
      primaryExamId: primaryExamId ?? this.primaryExamId,
      planningMode: planningMode ?? this.planningMode,
      dailyIntensity: dailyIntensity ?? this.dailyIntensity,
      maxDailyMinutes: maxDailyMinutes ?? this.maxDailyMinutes,
      maxSessionMinutes: maxSessionMinutes ?? this.maxSessionMinutes,
      planningBufferPercent:
          planningBufferPercent ?? this.planningBufferPercent,
      revisionBufferDays: revisionBufferDays ?? this.revisionBufferDays,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (planType.present) {
      map['plan_type'] = Variable<String>(planType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (targetEndDate.present) {
      map['target_end_date'] = Variable<DateTime>(targetEndDate.value);
    }
    if (primaryExamId.present) {
      map['primary_exam_id'] = Variable<String>(primaryExamId.value);
    }
    if (planningMode.present) {
      map['planning_mode'] = Variable<String>(planningMode.value);
    }
    if (dailyIntensity.present) {
      map['daily_intensity'] = Variable<String>(dailyIntensity.value);
    }
    if (maxDailyMinutes.present) {
      map['max_daily_minutes'] = Variable<int>(maxDailyMinutes.value);
    }
    if (maxSessionMinutes.present) {
      map['max_session_minutes'] = Variable<int>(maxSessionMinutes.value);
    }
    if (planningBufferPercent.present) {
      map['planning_buffer_percent'] = Variable<int>(
        planningBufferPercent.value,
      );
    }
    if (revisionBufferDays.present) {
      map['revision_buffer_days'] = Variable<int>(revisionBufferDays.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyPlansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('planType: $planType, ')
          ..write('status: $status, ')
          ..write('startDate: $startDate, ')
          ..write('targetEndDate: $targetEndDate, ')
          ..write('primaryExamId: $primaryExamId, ')
          ..write('planningMode: $planningMode, ')
          ..write('dailyIntensity: $dailyIntensity, ')
          ..write('maxDailyMinutes: $maxDailyMinutes, ')
          ..write('maxSessionMinutes: $maxSessionMinutes, ')
          ..write('planningBufferPercent: $planningBufferPercent, ')
          ..write('revisionBufferDays: $revisionBufferDays, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects
    with TableInfo<$SubjectsTable, SubjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyPlanIdMeta = const VerificationMeta(
    'studyPlanId',
  );
  @override
  late final GeneratedColumn<String> studyPlanId = GeneratedColumn<String>(
    'study_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paperNameMeta = const VerificationMeta(
    'paperName',
  );
  @override
  late final GeneratedColumn<String> paperName = GeneratedColumn<String>(
    'paper_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorTokenMeta = const VerificationMeta(
    'colorToken',
  );
  @override
  late final GeneratedColumn<String> colorToken = GeneratedColumn<String>(
    'color_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconTokenMeta = const VerificationMeta(
    'iconToken',
  );
  @override
  late final GeneratedColumn<String> iconToken = GeneratedColumn<String>(
    'icon_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<String> confidence = GeneratedColumn<String>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studyPlanId,
    name,
    code,
    paperName,
    colorToken,
    iconToken,
    priority,
    difficulty,
    confidence,
    status,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubjectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('study_plan_id')) {
      context.handle(
        _studyPlanIdMeta,
        studyPlanId.isAcceptableOrUnknown(
          data['study_plan_id']!,
          _studyPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyPlanIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    }
    if (data.containsKey('paper_name')) {
      context.handle(
        _paperNameMeta,
        paperName.isAcceptableOrUnknown(data['paper_name']!, _paperNameMeta),
      );
    }
    if (data.containsKey('color_token')) {
      context.handle(
        _colorTokenMeta,
        colorToken.isAcceptableOrUnknown(data['color_token']!, _colorTokenMeta),
      );
    } else if (isInserting) {
      context.missing(_colorTokenMeta);
    }
    if (data.containsKey('icon_token')) {
      context.handle(
        _iconTokenMeta,
        iconToken.isAcceptableOrUnknown(data['icon_token']!, _iconTokenMeta),
      );
    } else if (isInserting) {
      context.missing(_iconTokenMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubjectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studyPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_plan_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      ),
      paperName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paper_name'],
      ),
      colorToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_token'],
      )!,
      iconToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_token'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confidence'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class SubjectRow extends DataClass implements Insertable<SubjectRow> {
  final String id;
  final String studyPlanId;
  final String name;
  final String? code;
  final String? paperName;
  final String colorToken;
  final String iconToken;
  final String priority;
  final String difficulty;
  final String confidence;
  final String status;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SubjectRow({
    required this.id,
    required this.studyPlanId,
    required this.name,
    this.code,
    this.paperName,
    required this.colorToken,
    required this.iconToken,
    required this.priority,
    required this.difficulty,
    required this.confidence,
    required this.status,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['study_plan_id'] = Variable<String>(studyPlanId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || paperName != null) {
      map['paper_name'] = Variable<String>(paperName);
    }
    map['color_token'] = Variable<String>(colorToken);
    map['icon_token'] = Variable<String>(iconToken);
    map['priority'] = Variable<String>(priority);
    map['difficulty'] = Variable<String>(difficulty);
    map['confidence'] = Variable<String>(confidence);
    map['status'] = Variable<String>(status);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      studyPlanId: Value(studyPlanId),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      paperName: paperName == null && nullToAbsent
          ? const Value.absent()
          : Value(paperName),
      colorToken: Value(colorToken),
      iconToken: Value(iconToken),
      priority: Value(priority),
      difficulty: Value(difficulty),
      confidence: Value(confidence),
      status: Value(status),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SubjectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubjectRow(
      id: serializer.fromJson<String>(json['id']),
      studyPlanId: serializer.fromJson<String>(json['studyPlanId']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      paperName: serializer.fromJson<String?>(json['paperName']),
      colorToken: serializer.fromJson<String>(json['colorToken']),
      iconToken: serializer.fromJson<String>(json['iconToken']),
      priority: serializer.fromJson<String>(json['priority']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      confidence: serializer.fromJson<String>(json['confidence']),
      status: serializer.fromJson<String>(json['status']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studyPlanId': serializer.toJson<String>(studyPlanId),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'paperName': serializer.toJson<String?>(paperName),
      'colorToken': serializer.toJson<String>(colorToken),
      'iconToken': serializer.toJson<String>(iconToken),
      'priority': serializer.toJson<String>(priority),
      'difficulty': serializer.toJson<String>(difficulty),
      'confidence': serializer.toJson<String>(confidence),
      'status': serializer.toJson<String>(status),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SubjectRow copyWith({
    String? id,
    String? studyPlanId,
    String? name,
    Value<String?> code = const Value.absent(),
    Value<String?> paperName = const Value.absent(),
    String? colorToken,
    String? iconToken,
    String? priority,
    String? difficulty,
    String? confidence,
    String? status,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SubjectRow(
    id: id ?? this.id,
    studyPlanId: studyPlanId ?? this.studyPlanId,
    name: name ?? this.name,
    code: code.present ? code.value : this.code,
    paperName: paperName.present ? paperName.value : this.paperName,
    colorToken: colorToken ?? this.colorToken,
    iconToken: iconToken ?? this.iconToken,
    priority: priority ?? this.priority,
    difficulty: difficulty ?? this.difficulty,
    confidence: confidence ?? this.confidence,
    status: status ?? this.status,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SubjectRow copyWithCompanion(SubjectsCompanion data) {
    return SubjectRow(
      id: data.id.present ? data.id.value : this.id,
      studyPlanId: data.studyPlanId.present
          ? data.studyPlanId.value
          : this.studyPlanId,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      paperName: data.paperName.present ? data.paperName.value : this.paperName,
      colorToken: data.colorToken.present
          ? data.colorToken.value
          : this.colorToken,
      iconToken: data.iconToken.present ? data.iconToken.value : this.iconToken,
      priority: data.priority.present ? data.priority.value : this.priority,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      status: data.status.present ? data.status.value : this.status,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubjectRow(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('paperName: $paperName, ')
          ..write('colorToken: $colorToken, ')
          ..write('iconToken: $iconToken, ')
          ..write('priority: $priority, ')
          ..write('difficulty: $difficulty, ')
          ..write('confidence: $confidence, ')
          ..write('status: $status, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studyPlanId,
    name,
    code,
    paperName,
    colorToken,
    iconToken,
    priority,
    difficulty,
    confidence,
    status,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubjectRow &&
          other.id == this.id &&
          other.studyPlanId == this.studyPlanId &&
          other.name == this.name &&
          other.code == this.code &&
          other.paperName == this.paperName &&
          other.colorToken == this.colorToken &&
          other.iconToken == this.iconToken &&
          other.priority == this.priority &&
          other.difficulty == this.difficulty &&
          other.confidence == this.confidence &&
          other.status == this.status &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubjectsCompanion extends UpdateCompanion<SubjectRow> {
  final Value<String> id;
  final Value<String> studyPlanId;
  final Value<String> name;
  final Value<String?> code;
  final Value<String?> paperName;
  final Value<String> colorToken;
  final Value<String> iconToken;
  final Value<String> priority;
  final Value<String> difficulty;
  final Value<String> confidence;
  final Value<String> status;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.studyPlanId = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.paperName = const Value.absent(),
    this.colorToken = const Value.absent(),
    this.iconToken = const Value.absent(),
    this.priority = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.confidence = const Value.absent(),
    this.status = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubjectsCompanion.insert({
    required String id,
    required String studyPlanId,
    required String name,
    this.code = const Value.absent(),
    this.paperName = const Value.absent(),
    required String colorToken,
    required String iconToken,
    required String priority,
    required String difficulty,
    required String confidence,
    required String status,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studyPlanId = Value(studyPlanId),
       name = Value(name),
       colorToken = Value(colorToken),
       iconToken = Value(iconToken),
       priority = Value(priority),
       difficulty = Value(difficulty),
       confidence = Value(confidence),
       status = Value(status),
       sortOrder = Value(sortOrder),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SubjectRow> custom({
    Expression<String>? id,
    Expression<String>? studyPlanId,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? paperName,
    Expression<String>? colorToken,
    Expression<String>? iconToken,
    Expression<String>? priority,
    Expression<String>? difficulty,
    Expression<String>? confidence,
    Expression<String>? status,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studyPlanId != null) 'study_plan_id': studyPlanId,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (paperName != null) 'paper_name': paperName,
      if (colorToken != null) 'color_token': colorToken,
      if (iconToken != null) 'icon_token': iconToken,
      if (priority != null) 'priority': priority,
      if (difficulty != null) 'difficulty': difficulty,
      if (confidence != null) 'confidence': confidence,
      if (status != null) 'status': status,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? studyPlanId,
    Value<String>? name,
    Value<String?>? code,
    Value<String?>? paperName,
    Value<String>? colorToken,
    Value<String>? iconToken,
    Value<String>? priority,
    Value<String>? difficulty,
    Value<String>? confidence,
    Value<String>? status,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SubjectsCompanion(
      id: id ?? this.id,
      studyPlanId: studyPlanId ?? this.studyPlanId,
      name: name ?? this.name,
      code: code ?? this.code,
      paperName: paperName ?? this.paperName,
      colorToken: colorToken ?? this.colorToken,
      iconToken: iconToken ?? this.iconToken,
      priority: priority ?? this.priority,
      difficulty: difficulty ?? this.difficulty,
      confidence: confidence ?? this.confidence,
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studyPlanId.present) {
      map['study_plan_id'] = Variable<String>(studyPlanId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (paperName.present) {
      map['paper_name'] = Variable<String>(paperName.value);
    }
    if (colorToken.present) {
      map['color_token'] = Variable<String>(colorToken.value);
    }
    if (iconToken.present) {
      map['icon_token'] = Variable<String>(iconToken.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<String>(confidence.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('paperName: $paperName, ')
          ..write('colorToken: $colorToken, ')
          ..write('iconToken: $iconToken, ')
          ..write('priority: $priority, ')
          ..write('difficulty: $difficulty, ')
          ..write('confidence: $confidence, ')
          ..write('status: $status, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChaptersTable extends Chapters
    with TableInfo<$ChaptersTable, ChapterRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChaptersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterNumberMeta = const VerificationMeta(
    'chapterNumber',
  );
  @override
  late final GeneratedColumn<int> chapterNumber = GeneratedColumn<int>(
    'chapter_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMinutesMeta = const VerificationMeta(
    'completedMinutes',
  );
  @override
  late final GeneratedColumn<int> completedMinutes = GeneratedColumn<int>(
    'completed_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<String> confidence = GeneratedColumn<String>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examImportanceMeta = const VerificationMeta(
    'examImportance',
  );
  @override
  late final GeneratedColumn<String> examImportance = GeneratedColumn<String>(
    'exam_importance',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    title,
    chapterNumber,
    estimatedMinutes,
    completedMinutes,
    difficulty,
    confidence,
    priority,
    examImportance,
    status,
    notes,
    sortOrder,
    createdAt,
    updatedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChapterRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('chapter_number')) {
      context.handle(
        _chapterNumberMeta,
        chapterNumber.isAcceptableOrUnknown(
          data['chapter_number']!,
          _chapterNumberMeta,
        ),
      );
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedMinutesMeta);
    }
    if (data.containsKey('completed_minutes')) {
      context.handle(
        _completedMinutesMeta,
        completedMinutes.isAcceptableOrUnknown(
          data['completed_minutes']!,
          _completedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedMinutesMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('exam_importance')) {
      context.handle(
        _examImportanceMeta,
        examImportance.isAcceptableOrUnknown(
          data['exam_importance']!,
          _examImportanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_examImportanceMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChapterRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChapterRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      chapterNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_number'],
      ),
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
      completedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_minutes'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confidence'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      examImportance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_importance'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }
}

class ChapterRow extends DataClass implements Insertable<ChapterRow> {
  final String id;
  final String subjectId;
  final String title;
  final int? chapterNumber;
  final int estimatedMinutes;
  final int completedMinutes;
  final String difficulty;
  final String confidence;
  final String priority;
  final String examImportance;
  final String status;
  final String? notes;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  const ChapterRow({
    required this.id,
    required this.subjectId,
    required this.title,
    this.chapterNumber,
    required this.estimatedMinutes,
    required this.completedMinutes,
    required this.difficulty,
    required this.confidence,
    required this.priority,
    required this.examImportance,
    required this.status,
    this.notes,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subject_id'] = Variable<String>(subjectId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || chapterNumber != null) {
      map['chapter_number'] = Variable<int>(chapterNumber);
    }
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['completed_minutes'] = Variable<int>(completedMinutes);
    map['difficulty'] = Variable<String>(difficulty);
    map['confidence'] = Variable<String>(confidence);
    map['priority'] = Variable<String>(priority);
    map['exam_importance'] = Variable<String>(examImportance);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  ChaptersCompanion toCompanion(bool nullToAbsent) {
    return ChaptersCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      title: Value(title),
      chapterNumber: chapterNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterNumber),
      estimatedMinutes: Value(estimatedMinutes),
      completedMinutes: Value(completedMinutes),
      difficulty: Value(difficulty),
      confidence: Value(confidence),
      priority: Value(priority),
      examImportance: Value(examImportance),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory ChapterRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChapterRow(
      id: serializer.fromJson<String>(json['id']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      title: serializer.fromJson<String>(json['title']),
      chapterNumber: serializer.fromJson<int?>(json['chapterNumber']),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      completedMinutes: serializer.fromJson<int>(json['completedMinutes']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      confidence: serializer.fromJson<String>(json['confidence']),
      priority: serializer.fromJson<String>(json['priority']),
      examImportance: serializer.fromJson<String>(json['examImportance']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subjectId': serializer.toJson<String>(subjectId),
      'title': serializer.toJson<String>(title),
      'chapterNumber': serializer.toJson<int?>(chapterNumber),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'completedMinutes': serializer.toJson<int>(completedMinutes),
      'difficulty': serializer.toJson<String>(difficulty),
      'confidence': serializer.toJson<String>(confidence),
      'priority': serializer.toJson<String>(priority),
      'examImportance': serializer.toJson<String>(examImportance),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  ChapterRow copyWith({
    String? id,
    String? subjectId,
    String? title,
    Value<int?> chapterNumber = const Value.absent(),
    int? estimatedMinutes,
    int? completedMinutes,
    String? difficulty,
    String? confidence,
    String? priority,
    String? examImportance,
    String? status,
    Value<String?> notes = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => ChapterRow(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    title: title ?? this.title,
    chapterNumber: chapterNumber.present
        ? chapterNumber.value
        : this.chapterNumber,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    completedMinutes: completedMinutes ?? this.completedMinutes,
    difficulty: difficulty ?? this.difficulty,
    confidence: confidence ?? this.confidence,
    priority: priority ?? this.priority,
    examImportance: examImportance ?? this.examImportance,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  ChapterRow copyWithCompanion(ChaptersCompanion data) {
    return ChapterRow(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      title: data.title.present ? data.title.value : this.title,
      chapterNumber: data.chapterNumber.present
          ? data.chapterNumber.value
          : this.chapterNumber,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      completedMinutes: data.completedMinutes.present
          ? data.completedMinutes.value
          : this.completedMinutes,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      priority: data.priority.present ? data.priority.value : this.priority,
      examImportance: data.examImportance.present
          ? data.examImportance.value
          : this.examImportance,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChapterRow(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('chapterNumber: $chapterNumber, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('completedMinutes: $completedMinutes, ')
          ..write('difficulty: $difficulty, ')
          ..write('confidence: $confidence, ')
          ..write('priority: $priority, ')
          ..write('examImportance: $examImportance, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subjectId,
    title,
    chapterNumber,
    estimatedMinutes,
    completedMinutes,
    difficulty,
    confidence,
    priority,
    examImportance,
    status,
    notes,
    sortOrder,
    createdAt,
    updatedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChapterRow &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.title == this.title &&
          other.chapterNumber == this.chapterNumber &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.completedMinutes == this.completedMinutes &&
          other.difficulty == this.difficulty &&
          other.confidence == this.confidence &&
          other.priority == this.priority &&
          other.examImportance == this.examImportance &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt);
}

class ChaptersCompanion extends UpdateCompanion<ChapterRow> {
  final Value<String> id;
  final Value<String> subjectId;
  final Value<String> title;
  final Value<int?> chapterNumber;
  final Value<int> estimatedMinutes;
  final Value<int> completedMinutes;
  final Value<String> difficulty;
  final Value<String> confidence;
  final Value<String> priority;
  final Value<String> examImportance;
  final Value<String> status;
  final Value<String?> notes;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.title = const Value.absent(),
    this.chapterNumber = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.completedMinutes = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.confidence = const Value.absent(),
    this.priority = const Value.absent(),
    this.examImportance = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChaptersCompanion.insert({
    required String id,
    required String subjectId,
    required String title,
    this.chapterNumber = const Value.absent(),
    required int estimatedMinutes,
    required int completedMinutes,
    required String difficulty,
    required String confidence,
    required String priority,
    required String examImportance,
    required String status,
    this.notes = const Value.absent(),
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subjectId = Value(subjectId),
       title = Value(title),
       estimatedMinutes = Value(estimatedMinutes),
       completedMinutes = Value(completedMinutes),
       difficulty = Value(difficulty),
       confidence = Value(confidence),
       priority = Value(priority),
       examImportance = Value(examImportance),
       status = Value(status),
       sortOrder = Value(sortOrder),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ChapterRow> custom({
    Expression<String>? id,
    Expression<String>? subjectId,
    Expression<String>? title,
    Expression<int>? chapterNumber,
    Expression<int>? estimatedMinutes,
    Expression<int>? completedMinutes,
    Expression<String>? difficulty,
    Expression<String>? confidence,
    Expression<String>? priority,
    Expression<String>? examImportance,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (title != null) 'title': title,
      if (chapterNumber != null) 'chapter_number': chapterNumber,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (completedMinutes != null) 'completed_minutes': completedMinutes,
      if (difficulty != null) 'difficulty': difficulty,
      if (confidence != null) 'confidence': confidence,
      if (priority != null) 'priority': priority,
      if (examImportance != null) 'exam_importance': examImportance,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChaptersCompanion copyWith({
    Value<String>? id,
    Value<String>? subjectId,
    Value<String>? title,
    Value<int?>? chapterNumber,
    Value<int>? estimatedMinutes,
    Value<int>? completedMinutes,
    Value<String>? difficulty,
    Value<String>? confidence,
    Value<String>? priority,
    Value<String>? examImportance,
    Value<String>? status,
    Value<String?>? notes,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return ChaptersCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      completedMinutes: completedMinutes ?? this.completedMinutes,
      difficulty: difficulty ?? this.difficulty,
      confidence: confidence ?? this.confidence,
      priority: priority ?? this.priority,
      examImportance: examImportance ?? this.examImportance,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (chapterNumber.present) {
      map['chapter_number'] = Variable<int>(chapterNumber.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (completedMinutes.present) {
      map['completed_minutes'] = Variable<int>(completedMinutes.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<String>(confidence.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (examImportance.present) {
      map['exam_importance'] = Variable<String>(examImportance.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChaptersCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('chapterNumber: $chapterNumber, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('completedMinutes: $completedMinutes, ')
          ..write('difficulty: $difficulty, ')
          ..write('confidence: $confidence, ')
          ..write('priority: $priority, ')
          ..write('examImportance: $examImportance, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamsTable extends Exams with TableInfo<$ExamsTable, ExamRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyPlanIdMeta = const VerificationMeta(
    'studyPlanId',
  );
  @override
  late final GeneratedColumn<String> studyPlanId = GeneratedColumn<String>(
    'study_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examTypeMeta = const VerificationMeta(
    'examType',
  );
  @override
  late final GeneratedColumn<String> examType = GeneratedColumn<String>(
    'exam_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<int> timeOfDay = GeneratedColumn<int>(
    'time_of_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _importanceMeta = const VerificationMeta(
    'importance',
  );
  @override
  late final GeneratedColumn<String> importance = GeneratedColumn<String>(
    'importance',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studyPlanId,
    name,
    examType,
    startDate,
    endDate,
    timeOfDay,
    importance,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exams';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExamRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('study_plan_id')) {
      context.handle(
        _studyPlanIdMeta,
        studyPlanId.isAcceptableOrUnknown(
          data['study_plan_id']!,
          _studyPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyPlanIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('exam_type')) {
      context.handle(
        _examTypeMeta,
        examType.isAcceptableOrUnknown(data['exam_type']!, _examTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_examTypeMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    }
    if (data.containsKey('importance')) {
      context.handle(
        _importanceMeta,
        importance.isAcceptableOrUnknown(data['importance']!, _importanceMeta),
      );
    } else if (isInserting) {
      context.missing(_importanceMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studyPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_plan_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      examType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_type'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      timeOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_of_day'],
      ),
      importance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}importance'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ExamsTable createAlias(String alias) {
    return $ExamsTable(attachedDatabase, alias);
  }
}

class ExamRow extends DataClass implements Insertable<ExamRow> {
  final String id;
  final String studyPlanId;
  final String name;
  final String examType;
  final DateTime startDate;
  final DateTime? endDate;
  final int? timeOfDay;
  final String importance;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExamRow({
    required this.id,
    required this.studyPlanId,
    required this.name,
    required this.examType,
    required this.startDate,
    this.endDate,
    this.timeOfDay,
    required this.importance,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['study_plan_id'] = Variable<String>(studyPlanId);
    map['name'] = Variable<String>(name);
    map['exam_type'] = Variable<String>(examType);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || timeOfDay != null) {
      map['time_of_day'] = Variable<int>(timeOfDay);
    }
    map['importance'] = Variable<String>(importance);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExamsCompanion toCompanion(bool nullToAbsent) {
    return ExamsCompanion(
      id: Value(id),
      studyPlanId: Value(studyPlanId),
      name: Value(name),
      examType: Value(examType),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      timeOfDay: timeOfDay == null && nullToAbsent
          ? const Value.absent()
          : Value(timeOfDay),
      importance: Value(importance),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExamRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamRow(
      id: serializer.fromJson<String>(json['id']),
      studyPlanId: serializer.fromJson<String>(json['studyPlanId']),
      name: serializer.fromJson<String>(json['name']),
      examType: serializer.fromJson<String>(json['examType']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      timeOfDay: serializer.fromJson<int?>(json['timeOfDay']),
      importance: serializer.fromJson<String>(json['importance']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studyPlanId': serializer.toJson<String>(studyPlanId),
      'name': serializer.toJson<String>(name),
      'examType': serializer.toJson<String>(examType),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'timeOfDay': serializer.toJson<int?>(timeOfDay),
      'importance': serializer.toJson<String>(importance),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExamRow copyWith({
    String? id,
    String? studyPlanId,
    String? name,
    String? examType,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    Value<int?> timeOfDay = const Value.absent(),
    String? importance,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ExamRow(
    id: id ?? this.id,
    studyPlanId: studyPlanId ?? this.studyPlanId,
    name: name ?? this.name,
    examType: examType ?? this.examType,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    timeOfDay: timeOfDay.present ? timeOfDay.value : this.timeOfDay,
    importance: importance ?? this.importance,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ExamRow copyWithCompanion(ExamsCompanion data) {
    return ExamRow(
      id: data.id.present ? data.id.value : this.id,
      studyPlanId: data.studyPlanId.present
          ? data.studyPlanId.value
          : this.studyPlanId,
      name: data.name.present ? data.name.value : this.name,
      examType: data.examType.present ? data.examType.value : this.examType,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      importance: data.importance.present
          ? data.importance.value
          : this.importance,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamRow(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('name: $name, ')
          ..write('examType: $examType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('importance: $importance, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studyPlanId,
    name,
    examType,
    startDate,
    endDate,
    timeOfDay,
    importance,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamRow &&
          other.id == this.id &&
          other.studyPlanId == this.studyPlanId &&
          other.name == this.name &&
          other.examType == this.examType &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.timeOfDay == this.timeOfDay &&
          other.importance == this.importance &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExamsCompanion extends UpdateCompanion<ExamRow> {
  final Value<String> id;
  final Value<String> studyPlanId;
  final Value<String> name;
  final Value<String> examType;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<int?> timeOfDay;
  final Value<String> importance;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExamsCompanion({
    this.id = const Value.absent(),
    this.studyPlanId = const Value.absent(),
    this.name = const Value.absent(),
    this.examType = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.importance = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamsCompanion.insert({
    required String id,
    required String studyPlanId,
    required String name,
    required String examType,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    required String importance,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studyPlanId = Value(studyPlanId),
       name = Value(name),
       examType = Value(examType),
       startDate = Value(startDate),
       importance = Value(importance),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ExamRow> custom({
    Expression<String>? id,
    Expression<String>? studyPlanId,
    Expression<String>? name,
    Expression<String>? examType,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? timeOfDay,
    Expression<String>? importance,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studyPlanId != null) 'study_plan_id': studyPlanId,
      if (name != null) 'name': name,
      if (examType != null) 'exam_type': examType,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (importance != null) 'importance': importance,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamsCompanion copyWith({
    Value<String>? id,
    Value<String>? studyPlanId,
    Value<String>? name,
    Value<String>? examType,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<int?>? timeOfDay,
    Value<String>? importance,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ExamsCompanion(
      id: id ?? this.id,
      studyPlanId: studyPlanId ?? this.studyPlanId,
      name: name ?? this.name,
      examType: examType ?? this.examType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      importance: importance ?? this.importance,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studyPlanId.present) {
      map['study_plan_id'] = Variable<String>(studyPlanId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (examType.present) {
      map['exam_type'] = Variable<String>(examType.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<int>(timeOfDay.value);
    }
    if (importance.present) {
      map['importance'] = Variable<String>(importance.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamsCompanion(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('name: $name, ')
          ..write('examType: $examType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('importance: $importance, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamSyllabusItemsTable extends ExamSyllabusItems
    with TableInfo<$ExamSyllabusItemsTable, ExamSyllabusItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamSyllabusItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<String> examId = GeneratedColumn<String>(
    'exam_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exams (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRequiredMeta = const VerificationMeta(
    'isRequired',
  );
  @override
  late final GeneratedColumn<bool> isRequired = GeneratedColumn<bool>(
    'is_required',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_required" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    examId,
    subjectId,
    chapterId,
    topicId,
    weight,
    isRequired,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_syllabus_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExamSyllabusItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exam_id')) {
      context.handle(
        _examIdMeta,
        examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta),
      );
    } else if (isInserting) {
      context.missing(_examIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('is_required')) {
      context.handle(
        _isRequiredMeta,
        isRequired.isAcceptableOrUnknown(data['is_required']!, _isRequiredMeta),
      );
    } else if (isInserting) {
      context.missing(_isRequiredMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamSyllabusItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamSyllabusItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      examId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      ),
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      )!,
      isRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_required'],
      )!,
    );
  }

  @override
  $ExamSyllabusItemsTable createAlias(String alias) {
    return $ExamSyllabusItemsTable(attachedDatabase, alias);
  }
}

class ExamSyllabusItemRow extends DataClass
    implements Insertable<ExamSyllabusItemRow> {
  final String id;
  final String examId;
  final String subjectId;
  final String? chapterId;

  /// Topics are not a table yet. The id is kept so a later migration can
  /// attach a foreign key without rewriting syllabus rows.
  final String? topicId;
  final int weight;
  final bool isRequired;
  const ExamSyllabusItemRow({
    required this.id,
    required this.examId,
    required this.subjectId,
    this.chapterId,
    this.topicId,
    required this.weight,
    required this.isRequired,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exam_id'] = Variable<String>(examId);
    map['subject_id'] = Variable<String>(subjectId);
    if (!nullToAbsent || chapterId != null) {
      map['chapter_id'] = Variable<String>(chapterId);
    }
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<String>(topicId);
    }
    map['weight'] = Variable<int>(weight);
    map['is_required'] = Variable<bool>(isRequired);
    return map;
  }

  ExamSyllabusItemsCompanion toCompanion(bool nullToAbsent) {
    return ExamSyllabusItemsCompanion(
      id: Value(id),
      examId: Value(examId),
      subjectId: Value(subjectId),
      chapterId: chapterId == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterId),
      topicId: topicId == null && nullToAbsent
          ? const Value.absent()
          : Value(topicId),
      weight: Value(weight),
      isRequired: Value(isRequired),
    );
  }

  factory ExamSyllabusItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamSyllabusItemRow(
      id: serializer.fromJson<String>(json['id']),
      examId: serializer.fromJson<String>(json['examId']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      chapterId: serializer.fromJson<String?>(json['chapterId']),
      topicId: serializer.fromJson<String?>(json['topicId']),
      weight: serializer.fromJson<int>(json['weight']),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'examId': serializer.toJson<String>(examId),
      'subjectId': serializer.toJson<String>(subjectId),
      'chapterId': serializer.toJson<String?>(chapterId),
      'topicId': serializer.toJson<String?>(topicId),
      'weight': serializer.toJson<int>(weight),
      'isRequired': serializer.toJson<bool>(isRequired),
    };
  }

  ExamSyllabusItemRow copyWith({
    String? id,
    String? examId,
    String? subjectId,
    Value<String?> chapterId = const Value.absent(),
    Value<String?> topicId = const Value.absent(),
    int? weight,
    bool? isRequired,
  }) => ExamSyllabusItemRow(
    id: id ?? this.id,
    examId: examId ?? this.examId,
    subjectId: subjectId ?? this.subjectId,
    chapterId: chapterId.present ? chapterId.value : this.chapterId,
    topicId: topicId.present ? topicId.value : this.topicId,
    weight: weight ?? this.weight,
    isRequired: isRequired ?? this.isRequired,
  );
  ExamSyllabusItemRow copyWithCompanion(ExamSyllabusItemsCompanion data) {
    return ExamSyllabusItemRow(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      weight: data.weight.present ? data.weight.value : this.weight,
      isRequired: data.isRequired.present
          ? data.isRequired.value
          : this.isRequired,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamSyllabusItemRow(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('subjectId: $subjectId, ')
          ..write('chapterId: $chapterId, ')
          ..write('topicId: $topicId, ')
          ..write('weight: $weight, ')
          ..write('isRequired: $isRequired')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    examId,
    subjectId,
    chapterId,
    topicId,
    weight,
    isRequired,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamSyllabusItemRow &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.subjectId == this.subjectId &&
          other.chapterId == this.chapterId &&
          other.topicId == this.topicId &&
          other.weight == this.weight &&
          other.isRequired == this.isRequired);
}

class ExamSyllabusItemsCompanion extends UpdateCompanion<ExamSyllabusItemRow> {
  final Value<String> id;
  final Value<String> examId;
  final Value<String> subjectId;
  final Value<String?> chapterId;
  final Value<String?> topicId;
  final Value<int> weight;
  final Value<bool> isRequired;
  final Value<int> rowid;
  const ExamSyllabusItemsCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.weight = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamSyllabusItemsCompanion.insert({
    required String id,
    required String examId,
    required String subjectId,
    this.chapterId = const Value.absent(),
    this.topicId = const Value.absent(),
    required int weight,
    required bool isRequired,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       examId = Value(examId),
       subjectId = Value(subjectId),
       weight = Value(weight),
       isRequired = Value(isRequired);
  static Insertable<ExamSyllabusItemRow> custom({
    Expression<String>? id,
    Expression<String>? examId,
    Expression<String>? subjectId,
    Expression<String>? chapterId,
    Expression<String>? topicId,
    Expression<int>? weight,
    Expression<bool>? isRequired,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (subjectId != null) 'subject_id': subjectId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (topicId != null) 'topic_id': topicId,
      if (weight != null) 'weight': weight,
      if (isRequired != null) 'is_required': isRequired,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamSyllabusItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? examId,
    Value<String>? subjectId,
    Value<String?>? chapterId,
    Value<String?>? topicId,
    Value<int>? weight,
    Value<bool>? isRequired,
    Value<int>? rowid,
  }) {
    return ExamSyllabusItemsCompanion(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      subjectId: subjectId ?? this.subjectId,
      chapterId: chapterId ?? this.chapterId,
      topicId: topicId ?? this.topicId,
      weight: weight ?? this.weight,
      isRequired: isRequired ?? this.isRequired,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<String>(examId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (isRequired.present) {
      map['is_required'] = Variable<bool>(isRequired.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamSyllabusItemsCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('subjectId: $subjectId, ')
          ..write('chapterId: $chapterId, ')
          ..write('topicId: $topicId, ')
          ..write('weight: $weight, ')
          ..write('isRequired: $isRequired, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyAvailabilitiesTable extends WeeklyAvailabilities
    with TableInfo<$WeeklyAvailabilitiesTable, WeeklyAvailabilityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyAvailabilitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyPlanIdMeta = const VerificationMeta(
    'studyPlanId',
  );
  @override
  late final GeneratedColumn<String> studyPlanId = GeneratedColumn<String>(
    'study_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _weekdayMeta = const VerificationMeta(
    'weekday',
  );
  @override
  late final GeneratedColumn<int> weekday = GeneratedColumn<int>(
    'weekday',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAvailableMinutesMeta =
      const VerificationMeta('totalAvailableMinutes');
  @override
  late final GeneratedColumn<int> totalAvailableMinutes = GeneratedColumn<int>(
    'total_available_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isStudyDayMeta = const VerificationMeta(
    'isStudyDay',
  );
  @override
  late final GeneratedColumn<bool> isStudyDay = GeneratedColumn<bool>(
    'is_study_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_study_day" IN (0, 1))',
    ),
  );
  static const VerificationMeta _preferredStartTimeMeta =
      const VerificationMeta('preferredStartTime');
  @override
  late final GeneratedColumn<int> preferredStartTime = GeneratedColumn<int>(
    'preferred_start_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preferredEndTimeMeta = const VerificationMeta(
    'preferredEndTime',
  );
  @override
  late final GeneratedColumn<int> preferredEndTime = GeneratedColumn<int>(
    'preferred_end_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studyPlanId,
    weekday,
    totalAvailableMinutes,
    isStudyDay,
    preferredStartTime,
    preferredEndTime,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_availability';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklyAvailabilityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('study_plan_id')) {
      context.handle(
        _studyPlanIdMeta,
        studyPlanId.isAcceptableOrUnknown(
          data['study_plan_id']!,
          _studyPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyPlanIdMeta);
    }
    if (data.containsKey('weekday')) {
      context.handle(
        _weekdayMeta,
        weekday.isAcceptableOrUnknown(data['weekday']!, _weekdayMeta),
      );
    } else if (isInserting) {
      context.missing(_weekdayMeta);
    }
    if (data.containsKey('total_available_minutes')) {
      context.handle(
        _totalAvailableMinutesMeta,
        totalAvailableMinutes.isAcceptableOrUnknown(
          data['total_available_minutes']!,
          _totalAvailableMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAvailableMinutesMeta);
    }
    if (data.containsKey('is_study_day')) {
      context.handle(
        _isStudyDayMeta,
        isStudyDay.isAcceptableOrUnknown(
          data['is_study_day']!,
          _isStudyDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isStudyDayMeta);
    }
    if (data.containsKey('preferred_start_time')) {
      context.handle(
        _preferredStartTimeMeta,
        preferredStartTime.isAcceptableOrUnknown(
          data['preferred_start_time']!,
          _preferredStartTimeMeta,
        ),
      );
    }
    if (data.containsKey('preferred_end_time')) {
      context.handle(
        _preferredEndTimeMeta,
        preferredEndTime.isAcceptableOrUnknown(
          data['preferred_end_time']!,
          _preferredEndTimeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyAvailabilityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyAvailabilityRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studyPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_plan_id'],
      )!,
      weekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekday'],
      )!,
      totalAvailableMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_available_minutes'],
      )!,
      isStudyDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_study_day'],
      )!,
      preferredStartTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preferred_start_time'],
      ),
      preferredEndTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preferred_end_time'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WeeklyAvailabilitiesTable createAlias(String alias) {
    return $WeeklyAvailabilitiesTable(attachedDatabase, alias);
  }
}

class WeeklyAvailabilityRow extends DataClass
    implements Insertable<WeeklyAvailabilityRow> {
  final String id;
  final String studyPlanId;

  /// ISO weekday: Monday is 1 and Sunday is 7, matching [DateTime.weekday].
  final int weekday;
  final int totalAvailableMinutes;
  final bool isStudyDay;
  final int? preferredStartTime;
  final int? preferredEndTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WeeklyAvailabilityRow({
    required this.id,
    required this.studyPlanId,
    required this.weekday,
    required this.totalAvailableMinutes,
    required this.isStudyDay,
    this.preferredStartTime,
    this.preferredEndTime,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['study_plan_id'] = Variable<String>(studyPlanId);
    map['weekday'] = Variable<int>(weekday);
    map['total_available_minutes'] = Variable<int>(totalAvailableMinutes);
    map['is_study_day'] = Variable<bool>(isStudyDay);
    if (!nullToAbsent || preferredStartTime != null) {
      map['preferred_start_time'] = Variable<int>(preferredStartTime);
    }
    if (!nullToAbsent || preferredEndTime != null) {
      map['preferred_end_time'] = Variable<int>(preferredEndTime);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WeeklyAvailabilitiesCompanion toCompanion(bool nullToAbsent) {
    return WeeklyAvailabilitiesCompanion(
      id: Value(id),
      studyPlanId: Value(studyPlanId),
      weekday: Value(weekday),
      totalAvailableMinutes: Value(totalAvailableMinutes),
      isStudyDay: Value(isStudyDay),
      preferredStartTime: preferredStartTime == null && nullToAbsent
          ? const Value.absent()
          : Value(preferredStartTime),
      preferredEndTime: preferredEndTime == null && nullToAbsent
          ? const Value.absent()
          : Value(preferredEndTime),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WeeklyAvailabilityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyAvailabilityRow(
      id: serializer.fromJson<String>(json['id']),
      studyPlanId: serializer.fromJson<String>(json['studyPlanId']),
      weekday: serializer.fromJson<int>(json['weekday']),
      totalAvailableMinutes: serializer.fromJson<int>(
        json['totalAvailableMinutes'],
      ),
      isStudyDay: serializer.fromJson<bool>(json['isStudyDay']),
      preferredStartTime: serializer.fromJson<int?>(json['preferredStartTime']),
      preferredEndTime: serializer.fromJson<int?>(json['preferredEndTime']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studyPlanId': serializer.toJson<String>(studyPlanId),
      'weekday': serializer.toJson<int>(weekday),
      'totalAvailableMinutes': serializer.toJson<int>(totalAvailableMinutes),
      'isStudyDay': serializer.toJson<bool>(isStudyDay),
      'preferredStartTime': serializer.toJson<int?>(preferredStartTime),
      'preferredEndTime': serializer.toJson<int?>(preferredEndTime),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WeeklyAvailabilityRow copyWith({
    String? id,
    String? studyPlanId,
    int? weekday,
    int? totalAvailableMinutes,
    bool? isStudyDay,
    Value<int?> preferredStartTime = const Value.absent(),
    Value<int?> preferredEndTime = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WeeklyAvailabilityRow(
    id: id ?? this.id,
    studyPlanId: studyPlanId ?? this.studyPlanId,
    weekday: weekday ?? this.weekday,
    totalAvailableMinutes: totalAvailableMinutes ?? this.totalAvailableMinutes,
    isStudyDay: isStudyDay ?? this.isStudyDay,
    preferredStartTime: preferredStartTime.present
        ? preferredStartTime.value
        : this.preferredStartTime,
    preferredEndTime: preferredEndTime.present
        ? preferredEndTime.value
        : this.preferredEndTime,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WeeklyAvailabilityRow copyWithCompanion(WeeklyAvailabilitiesCompanion data) {
    return WeeklyAvailabilityRow(
      id: data.id.present ? data.id.value : this.id,
      studyPlanId: data.studyPlanId.present
          ? data.studyPlanId.value
          : this.studyPlanId,
      weekday: data.weekday.present ? data.weekday.value : this.weekday,
      totalAvailableMinutes: data.totalAvailableMinutes.present
          ? data.totalAvailableMinutes.value
          : this.totalAvailableMinutes,
      isStudyDay: data.isStudyDay.present
          ? data.isStudyDay.value
          : this.isStudyDay,
      preferredStartTime: data.preferredStartTime.present
          ? data.preferredStartTime.value
          : this.preferredStartTime,
      preferredEndTime: data.preferredEndTime.present
          ? data.preferredEndTime.value
          : this.preferredEndTime,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyAvailabilityRow(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('weekday: $weekday, ')
          ..write('totalAvailableMinutes: $totalAvailableMinutes, ')
          ..write('isStudyDay: $isStudyDay, ')
          ..write('preferredStartTime: $preferredStartTime, ')
          ..write('preferredEndTime: $preferredEndTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studyPlanId,
    weekday,
    totalAvailableMinutes,
    isStudyDay,
    preferredStartTime,
    preferredEndTime,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyAvailabilityRow &&
          other.id == this.id &&
          other.studyPlanId == this.studyPlanId &&
          other.weekday == this.weekday &&
          other.totalAvailableMinutes == this.totalAvailableMinutes &&
          other.isStudyDay == this.isStudyDay &&
          other.preferredStartTime == this.preferredStartTime &&
          other.preferredEndTime == this.preferredEndTime &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WeeklyAvailabilitiesCompanion
    extends UpdateCompanion<WeeklyAvailabilityRow> {
  final Value<String> id;
  final Value<String> studyPlanId;
  final Value<int> weekday;
  final Value<int> totalAvailableMinutes;
  final Value<bool> isStudyDay;
  final Value<int?> preferredStartTime;
  final Value<int?> preferredEndTime;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WeeklyAvailabilitiesCompanion({
    this.id = const Value.absent(),
    this.studyPlanId = const Value.absent(),
    this.weekday = const Value.absent(),
    this.totalAvailableMinutes = const Value.absent(),
    this.isStudyDay = const Value.absent(),
    this.preferredStartTime = const Value.absent(),
    this.preferredEndTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyAvailabilitiesCompanion.insert({
    required String id,
    required String studyPlanId,
    required int weekday,
    required int totalAvailableMinutes,
    required bool isStudyDay,
    this.preferredStartTime = const Value.absent(),
    this.preferredEndTime = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studyPlanId = Value(studyPlanId),
       weekday = Value(weekday),
       totalAvailableMinutes = Value(totalAvailableMinutes),
       isStudyDay = Value(isStudyDay),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WeeklyAvailabilityRow> custom({
    Expression<String>? id,
    Expression<String>? studyPlanId,
    Expression<int>? weekday,
    Expression<int>? totalAvailableMinutes,
    Expression<bool>? isStudyDay,
    Expression<int>? preferredStartTime,
    Expression<int>? preferredEndTime,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studyPlanId != null) 'study_plan_id': studyPlanId,
      if (weekday != null) 'weekday': weekday,
      if (totalAvailableMinutes != null)
        'total_available_minutes': totalAvailableMinutes,
      if (isStudyDay != null) 'is_study_day': isStudyDay,
      if (preferredStartTime != null)
        'preferred_start_time': preferredStartTime,
      if (preferredEndTime != null) 'preferred_end_time': preferredEndTime,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyAvailabilitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? studyPlanId,
    Value<int>? weekday,
    Value<int>? totalAvailableMinutes,
    Value<bool>? isStudyDay,
    Value<int?>? preferredStartTime,
    Value<int?>? preferredEndTime,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WeeklyAvailabilitiesCompanion(
      id: id ?? this.id,
      studyPlanId: studyPlanId ?? this.studyPlanId,
      weekday: weekday ?? this.weekday,
      totalAvailableMinutes:
          totalAvailableMinutes ?? this.totalAvailableMinutes,
      isStudyDay: isStudyDay ?? this.isStudyDay,
      preferredStartTime: preferredStartTime ?? this.preferredStartTime,
      preferredEndTime: preferredEndTime ?? this.preferredEndTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studyPlanId.present) {
      map['study_plan_id'] = Variable<String>(studyPlanId.value);
    }
    if (weekday.present) {
      map['weekday'] = Variable<int>(weekday.value);
    }
    if (totalAvailableMinutes.present) {
      map['total_available_minutes'] = Variable<int>(
        totalAvailableMinutes.value,
      );
    }
    if (isStudyDay.present) {
      map['is_study_day'] = Variable<bool>(isStudyDay.value);
    }
    if (preferredStartTime.present) {
      map['preferred_start_time'] = Variable<int>(preferredStartTime.value);
    }
    if (preferredEndTime.present) {
      map['preferred_end_time'] = Variable<int>(preferredEndTime.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyAvailabilitiesCompanion(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('weekday: $weekday, ')
          ..write('totalAvailableMinutes: $totalAvailableMinutes, ')
          ..write('isStudyDay: $isStudyDay, ')
          ..write('preferredStartTime: $preferredStartTime, ')
          ..write('preferredEndTime: $preferredEndTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CalendarExceptionsTable extends CalendarExceptions
    with TableInfo<$CalendarExceptionsTable, CalendarExceptionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarExceptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyPlanIdMeta = const VerificationMeta(
    'studyPlanId',
  );
  @override
  late final GeneratedColumn<String> studyPlanId = GeneratedColumn<String>(
    'study_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _exceptionDateMeta = const VerificationMeta(
    'exceptionDate',
  );
  @override
  late final GeneratedColumn<DateTime> exceptionDate =
      GeneratedColumn<DateTime>(
        'date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _exceptionTypeMeta = const VerificationMeta(
    'exceptionType',
  );
  @override
  late final GeneratedColumn<String> exceptionType = GeneratedColumn<String>(
    'exception_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _availableMinutesOverrideMeta =
      const VerificationMeta('availableMinutesOverride');
  @override
  late final GeneratedColumn<int> availableMinutesOverride =
      GeneratedColumn<int>(
        'available_minutes_override',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isNoStudyDayMeta = const VerificationMeta(
    'isNoStudyDay',
  );
  @override
  late final GeneratedColumn<bool> isNoStudyDay = GeneratedColumn<bool>(
    'is_no_study_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_no_study_day" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studyPlanId,
    exceptionDate,
    exceptionType,
    availableMinutesOverride,
    reason,
    isNoStudyDay,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calendar_exceptions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalendarExceptionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('study_plan_id')) {
      context.handle(
        _studyPlanIdMeta,
        studyPlanId.isAcceptableOrUnknown(
          data['study_plan_id']!,
          _studyPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyPlanIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _exceptionDateMeta,
        exceptionDate.isAcceptableOrUnknown(data['date']!, _exceptionDateMeta),
      );
    } else if (isInserting) {
      context.missing(_exceptionDateMeta);
    }
    if (data.containsKey('exception_type')) {
      context.handle(
        _exceptionTypeMeta,
        exceptionType.isAcceptableOrUnknown(
          data['exception_type']!,
          _exceptionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exceptionTypeMeta);
    }
    if (data.containsKey('available_minutes_override')) {
      context.handle(
        _availableMinutesOverrideMeta,
        availableMinutesOverride.isAcceptableOrUnknown(
          data['available_minutes_override']!,
          _availableMinutesOverrideMeta,
        ),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('is_no_study_day')) {
      context.handle(
        _isNoStudyDayMeta,
        isNoStudyDay.isAcceptableOrUnknown(
          data['is_no_study_day']!,
          _isNoStudyDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isNoStudyDayMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalendarExceptionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalendarExceptionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studyPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_plan_id'],
      )!,
      exceptionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      exceptionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exception_type'],
      )!,
      availableMinutesOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}available_minutes_override'],
      ),
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      isNoStudyDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_no_study_day'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CalendarExceptionsTable createAlias(String alias) {
    return $CalendarExceptionsTable(attachedDatabase, alias);
  }
}

class CalendarExceptionRow extends DataClass
    implements Insertable<CalendarExceptionRow> {
  final String id;
  final String studyPlanId;
  final DateTime exceptionDate;
  final String exceptionType;
  final int? availableMinutesOverride;
  final String? reason;
  final bool isNoStudyDay;
  final DateTime createdAt;
  const CalendarExceptionRow({
    required this.id,
    required this.studyPlanId,
    required this.exceptionDate,
    required this.exceptionType,
    this.availableMinutesOverride,
    this.reason,
    required this.isNoStudyDay,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['study_plan_id'] = Variable<String>(studyPlanId);
    map['date'] = Variable<DateTime>(exceptionDate);
    map['exception_type'] = Variable<String>(exceptionType);
    if (!nullToAbsent || availableMinutesOverride != null) {
      map['available_minutes_override'] = Variable<int>(
        availableMinutesOverride,
      );
    }
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['is_no_study_day'] = Variable<bool>(isNoStudyDay);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CalendarExceptionsCompanion toCompanion(bool nullToAbsent) {
    return CalendarExceptionsCompanion(
      id: Value(id),
      studyPlanId: Value(studyPlanId),
      exceptionDate: Value(exceptionDate),
      exceptionType: Value(exceptionType),
      availableMinutesOverride: availableMinutesOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(availableMinutesOverride),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      isNoStudyDay: Value(isNoStudyDay),
      createdAt: Value(createdAt),
    );
  }

  factory CalendarExceptionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarExceptionRow(
      id: serializer.fromJson<String>(json['id']),
      studyPlanId: serializer.fromJson<String>(json['studyPlanId']),
      exceptionDate: serializer.fromJson<DateTime>(json['exceptionDate']),
      exceptionType: serializer.fromJson<String>(json['exceptionType']),
      availableMinutesOverride: serializer.fromJson<int?>(
        json['availableMinutesOverride'],
      ),
      reason: serializer.fromJson<String?>(json['reason']),
      isNoStudyDay: serializer.fromJson<bool>(json['isNoStudyDay']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studyPlanId': serializer.toJson<String>(studyPlanId),
      'exceptionDate': serializer.toJson<DateTime>(exceptionDate),
      'exceptionType': serializer.toJson<String>(exceptionType),
      'availableMinutesOverride': serializer.toJson<int?>(
        availableMinutesOverride,
      ),
      'reason': serializer.toJson<String?>(reason),
      'isNoStudyDay': serializer.toJson<bool>(isNoStudyDay),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CalendarExceptionRow copyWith({
    String? id,
    String? studyPlanId,
    DateTime? exceptionDate,
    String? exceptionType,
    Value<int?> availableMinutesOverride = const Value.absent(),
    Value<String?> reason = const Value.absent(),
    bool? isNoStudyDay,
    DateTime? createdAt,
  }) => CalendarExceptionRow(
    id: id ?? this.id,
    studyPlanId: studyPlanId ?? this.studyPlanId,
    exceptionDate: exceptionDate ?? this.exceptionDate,
    exceptionType: exceptionType ?? this.exceptionType,
    availableMinutesOverride: availableMinutesOverride.present
        ? availableMinutesOverride.value
        : this.availableMinutesOverride,
    reason: reason.present ? reason.value : this.reason,
    isNoStudyDay: isNoStudyDay ?? this.isNoStudyDay,
    createdAt: createdAt ?? this.createdAt,
  );
  CalendarExceptionRow copyWithCompanion(CalendarExceptionsCompanion data) {
    return CalendarExceptionRow(
      id: data.id.present ? data.id.value : this.id,
      studyPlanId: data.studyPlanId.present
          ? data.studyPlanId.value
          : this.studyPlanId,
      exceptionDate: data.exceptionDate.present
          ? data.exceptionDate.value
          : this.exceptionDate,
      exceptionType: data.exceptionType.present
          ? data.exceptionType.value
          : this.exceptionType,
      availableMinutesOverride: data.availableMinutesOverride.present
          ? data.availableMinutesOverride.value
          : this.availableMinutesOverride,
      reason: data.reason.present ? data.reason.value : this.reason,
      isNoStudyDay: data.isNoStudyDay.present
          ? data.isNoStudyDay.value
          : this.isNoStudyDay,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalendarExceptionRow(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('exceptionDate: $exceptionDate, ')
          ..write('exceptionType: $exceptionType, ')
          ..write('availableMinutesOverride: $availableMinutesOverride, ')
          ..write('reason: $reason, ')
          ..write('isNoStudyDay: $isNoStudyDay, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studyPlanId,
    exceptionDate,
    exceptionType,
    availableMinutesOverride,
    reason,
    isNoStudyDay,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarExceptionRow &&
          other.id == this.id &&
          other.studyPlanId == this.studyPlanId &&
          other.exceptionDate == this.exceptionDate &&
          other.exceptionType == this.exceptionType &&
          other.availableMinutesOverride == this.availableMinutesOverride &&
          other.reason == this.reason &&
          other.isNoStudyDay == this.isNoStudyDay &&
          other.createdAt == this.createdAt);
}

class CalendarExceptionsCompanion
    extends UpdateCompanion<CalendarExceptionRow> {
  final Value<String> id;
  final Value<String> studyPlanId;
  final Value<DateTime> exceptionDate;
  final Value<String> exceptionType;
  final Value<int?> availableMinutesOverride;
  final Value<String?> reason;
  final Value<bool> isNoStudyDay;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CalendarExceptionsCompanion({
    this.id = const Value.absent(),
    this.studyPlanId = const Value.absent(),
    this.exceptionDate = const Value.absent(),
    this.exceptionType = const Value.absent(),
    this.availableMinutesOverride = const Value.absent(),
    this.reason = const Value.absent(),
    this.isNoStudyDay = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CalendarExceptionsCompanion.insert({
    required String id,
    required String studyPlanId,
    required DateTime exceptionDate,
    required String exceptionType,
    this.availableMinutesOverride = const Value.absent(),
    this.reason = const Value.absent(),
    required bool isNoStudyDay,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studyPlanId = Value(studyPlanId),
       exceptionDate = Value(exceptionDate),
       exceptionType = Value(exceptionType),
       isNoStudyDay = Value(isNoStudyDay),
       createdAt = Value(createdAt);
  static Insertable<CalendarExceptionRow> custom({
    Expression<String>? id,
    Expression<String>? studyPlanId,
    Expression<DateTime>? exceptionDate,
    Expression<String>? exceptionType,
    Expression<int>? availableMinutesOverride,
    Expression<String>? reason,
    Expression<bool>? isNoStudyDay,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studyPlanId != null) 'study_plan_id': studyPlanId,
      if (exceptionDate != null) 'date': exceptionDate,
      if (exceptionType != null) 'exception_type': exceptionType,
      if (availableMinutesOverride != null)
        'available_minutes_override': availableMinutesOverride,
      if (reason != null) 'reason': reason,
      if (isNoStudyDay != null) 'is_no_study_day': isNoStudyDay,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CalendarExceptionsCompanion copyWith({
    Value<String>? id,
    Value<String>? studyPlanId,
    Value<DateTime>? exceptionDate,
    Value<String>? exceptionType,
    Value<int?>? availableMinutesOverride,
    Value<String?>? reason,
    Value<bool>? isNoStudyDay,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CalendarExceptionsCompanion(
      id: id ?? this.id,
      studyPlanId: studyPlanId ?? this.studyPlanId,
      exceptionDate: exceptionDate ?? this.exceptionDate,
      exceptionType: exceptionType ?? this.exceptionType,
      availableMinutesOverride:
          availableMinutesOverride ?? this.availableMinutesOverride,
      reason: reason ?? this.reason,
      isNoStudyDay: isNoStudyDay ?? this.isNoStudyDay,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studyPlanId.present) {
      map['study_plan_id'] = Variable<String>(studyPlanId.value);
    }
    if (exceptionDate.present) {
      map['date'] = Variable<DateTime>(exceptionDate.value);
    }
    if (exceptionType.present) {
      map['exception_type'] = Variable<String>(exceptionType.value);
    }
    if (availableMinutesOverride.present) {
      map['available_minutes_override'] = Variable<int>(
        availableMinutesOverride.value,
      );
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (isNoStudyDay.present) {
      map['is_no_study_day'] = Variable<bool>(isNoStudyDay.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarExceptionsCompanion(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('exceptionDate: $exceptionDate, ')
          ..write('exceptionType: $exceptionType, ')
          ..write('availableMinutesOverride: $availableMinutesOverride, ')
          ..write('reason: $reason, ')
          ..write('isNoStudyDay: $isNoStudyDay, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyTasksTable extends StudyTasks
    with TableInfo<$StudyTasksTable, StudyTaskRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyPlanIdMeta = const VerificationMeta(
    'studyPlanId',
  );
  @override
  late final GeneratedColumn<String> studyPlanId = GeneratedColumn<String>(
    'study_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<String> examId = GeneratedColumn<String>(
    'exam_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exams (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _taskTypeMeta = const VerificationMeta(
    'taskType',
  );
  @override
  late final GeneratedColumn<String> taskType = GeneratedColumn<String>(
    'task_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedDateMeta = const VerificationMeta(
    'plannedDate',
  );
  @override
  late final GeneratedColumn<DateTime> plannedDate = GeneratedColumn<DateTime>(
    'planned_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedStartTimeMeta = const VerificationMeta(
    'plannedStartTime',
  );
  @override
  late final GeneratedColumn<int> plannedStartTime = GeneratedColumn<int>(
    'planned_start_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plannedMinutesMeta = const VerificationMeta(
    'plannedMinutes',
  );
  @override
  late final GeneratedColumn<int> plannedMinutes = GeneratedColumn<int>(
    'planned_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualMinutesMeta = const VerificationMeta(
    'actualMinutes',
  );
  @override
  late final GeneratedColumn<int> actualMinutes = GeneratedColumn<int>(
    'actual_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityScoreMeta = const VerificationMeta(
    'priorityScore',
  );
  @override
  late final GeneratedColumn<int> priorityScore = GeneratedColumn<int>(
    'priority_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isLockedMeta = const VerificationMeta(
    'isLocked',
  );
  @override
  late final GeneratedColumn<bool> isLocked = GeneratedColumn<bool>(
    'is_locked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_locked" IN (0, 1))',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completionPercentMeta = const VerificationMeta(
    'completionPercent',
  );
  @override
  late final GeneratedColumn<int> completionPercent = GeneratedColumn<int>(
    'completion_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generationBatchIdMeta = const VerificationMeta(
    'generationBatchId',
  );
  @override
  late final GeneratedColumn<String> generationBatchId =
      GeneratedColumn<String>(
        'generation_batch_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studyPlanId,
    subjectId,
    chapterId,
    topicId,
    examId,
    taskType,
    title,
    plannedDate,
    plannedStartTime,
    plannedMinutes,
    actualMinutes,
    priorityScore,
    isLocked,
    status,
    completionPercent,
    source,
    generationBatchId,
    createdAt,
    updatedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyTaskRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('study_plan_id')) {
      context.handle(
        _studyPlanIdMeta,
        studyPlanId.isAcceptableOrUnknown(
          data['study_plan_id']!,
          _studyPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyPlanIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('exam_id')) {
      context.handle(
        _examIdMeta,
        examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta),
      );
    }
    if (data.containsKey('task_type')) {
      context.handle(
        _taskTypeMeta,
        taskType.isAcceptableOrUnknown(data['task_type']!, _taskTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_taskTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('planned_date')) {
      context.handle(
        _plannedDateMeta,
        plannedDate.isAcceptableOrUnknown(
          data['planned_date']!,
          _plannedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedDateMeta);
    }
    if (data.containsKey('planned_start_time')) {
      context.handle(
        _plannedStartTimeMeta,
        plannedStartTime.isAcceptableOrUnknown(
          data['planned_start_time']!,
          _plannedStartTimeMeta,
        ),
      );
    }
    if (data.containsKey('planned_minutes')) {
      context.handle(
        _plannedMinutesMeta,
        plannedMinutes.isAcceptableOrUnknown(
          data['planned_minutes']!,
          _plannedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedMinutesMeta);
    }
    if (data.containsKey('actual_minutes')) {
      context.handle(
        _actualMinutesMeta,
        actualMinutes.isAcceptableOrUnknown(
          data['actual_minutes']!,
          _actualMinutesMeta,
        ),
      );
    }
    if (data.containsKey('priority_score')) {
      context.handle(
        _priorityScoreMeta,
        priorityScore.isAcceptableOrUnknown(
          data['priority_score']!,
          _priorityScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_priorityScoreMeta);
    }
    if (data.containsKey('is_locked')) {
      context.handle(
        _isLockedMeta,
        isLocked.isAcceptableOrUnknown(data['is_locked']!, _isLockedMeta),
      );
    } else if (isInserting) {
      context.missing(_isLockedMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('completion_percent')) {
      context.handle(
        _completionPercentMeta,
        completionPercent.isAcceptableOrUnknown(
          data['completion_percent']!,
          _completionPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completionPercentMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('generation_batch_id')) {
      context.handle(
        _generationBatchIdMeta,
        generationBatchId.isAcceptableOrUnknown(
          data['generation_batch_id']!,
          _generationBatchIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyTaskRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyTaskRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studyPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_plan_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      ),
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      ),
      examId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_id'],
      ),
      taskType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      plannedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}planned_date'],
      )!,
      plannedStartTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_start_time'],
      ),
      plannedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_minutes'],
      )!,
      actualMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_minutes'],
      ),
      priorityScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority_score'],
      )!,
      isLocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_locked'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      completionPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completion_percent'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      generationBatchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}generation_batch_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $StudyTasksTable createAlias(String alias) {
    return $StudyTasksTable(attachedDatabase, alias);
  }
}

class StudyTaskRow extends DataClass implements Insertable<StudyTaskRow> {
  final String id;
  final String studyPlanId;
  final String subjectId;
  final String? chapterId;
  final String? topicId;
  final String? examId;
  final String taskType;
  final String title;
  final DateTime plannedDate;
  final int? plannedStartTime;
  final int plannedMinutes;
  final int? actualMinutes;
  final int priorityScore;
  final bool isLocked;
  final String status;
  final int completionPercent;
  final String source;
  final String? generationBatchId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  const StudyTaskRow({
    required this.id,
    required this.studyPlanId,
    required this.subjectId,
    this.chapterId,
    this.topicId,
    this.examId,
    required this.taskType,
    required this.title,
    required this.plannedDate,
    this.plannedStartTime,
    required this.plannedMinutes,
    this.actualMinutes,
    required this.priorityScore,
    required this.isLocked,
    required this.status,
    required this.completionPercent,
    required this.source,
    this.generationBatchId,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['study_plan_id'] = Variable<String>(studyPlanId);
    map['subject_id'] = Variable<String>(subjectId);
    if (!nullToAbsent || chapterId != null) {
      map['chapter_id'] = Variable<String>(chapterId);
    }
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<String>(topicId);
    }
    if (!nullToAbsent || examId != null) {
      map['exam_id'] = Variable<String>(examId);
    }
    map['task_type'] = Variable<String>(taskType);
    map['title'] = Variable<String>(title);
    map['planned_date'] = Variable<DateTime>(plannedDate);
    if (!nullToAbsent || plannedStartTime != null) {
      map['planned_start_time'] = Variable<int>(plannedStartTime);
    }
    map['planned_minutes'] = Variable<int>(plannedMinutes);
    if (!nullToAbsent || actualMinutes != null) {
      map['actual_minutes'] = Variable<int>(actualMinutes);
    }
    map['priority_score'] = Variable<int>(priorityScore);
    map['is_locked'] = Variable<bool>(isLocked);
    map['status'] = Variable<String>(status);
    map['completion_percent'] = Variable<int>(completionPercent);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || generationBatchId != null) {
      map['generation_batch_id'] = Variable<String>(generationBatchId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  StudyTasksCompanion toCompanion(bool nullToAbsent) {
    return StudyTasksCompanion(
      id: Value(id),
      studyPlanId: Value(studyPlanId),
      subjectId: Value(subjectId),
      chapterId: chapterId == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterId),
      topicId: topicId == null && nullToAbsent
          ? const Value.absent()
          : Value(topicId),
      examId: examId == null && nullToAbsent
          ? const Value.absent()
          : Value(examId),
      taskType: Value(taskType),
      title: Value(title),
      plannedDate: Value(plannedDate),
      plannedStartTime: plannedStartTime == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedStartTime),
      plannedMinutes: Value(plannedMinutes),
      actualMinutes: actualMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(actualMinutes),
      priorityScore: Value(priorityScore),
      isLocked: Value(isLocked),
      status: Value(status),
      completionPercent: Value(completionPercent),
      source: Value(source),
      generationBatchId: generationBatchId == null && nullToAbsent
          ? const Value.absent()
          : Value(generationBatchId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory StudyTaskRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyTaskRow(
      id: serializer.fromJson<String>(json['id']),
      studyPlanId: serializer.fromJson<String>(json['studyPlanId']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      chapterId: serializer.fromJson<String?>(json['chapterId']),
      topicId: serializer.fromJson<String?>(json['topicId']),
      examId: serializer.fromJson<String?>(json['examId']),
      taskType: serializer.fromJson<String>(json['taskType']),
      title: serializer.fromJson<String>(json['title']),
      plannedDate: serializer.fromJson<DateTime>(json['plannedDate']),
      plannedStartTime: serializer.fromJson<int?>(json['plannedStartTime']),
      plannedMinutes: serializer.fromJson<int>(json['plannedMinutes']),
      actualMinutes: serializer.fromJson<int?>(json['actualMinutes']),
      priorityScore: serializer.fromJson<int>(json['priorityScore']),
      isLocked: serializer.fromJson<bool>(json['isLocked']),
      status: serializer.fromJson<String>(json['status']),
      completionPercent: serializer.fromJson<int>(json['completionPercent']),
      source: serializer.fromJson<String>(json['source']),
      generationBatchId: serializer.fromJson<String?>(
        json['generationBatchId'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studyPlanId': serializer.toJson<String>(studyPlanId),
      'subjectId': serializer.toJson<String>(subjectId),
      'chapterId': serializer.toJson<String?>(chapterId),
      'topicId': serializer.toJson<String?>(topicId),
      'examId': serializer.toJson<String?>(examId),
      'taskType': serializer.toJson<String>(taskType),
      'title': serializer.toJson<String>(title),
      'plannedDate': serializer.toJson<DateTime>(plannedDate),
      'plannedStartTime': serializer.toJson<int?>(plannedStartTime),
      'plannedMinutes': serializer.toJson<int>(plannedMinutes),
      'actualMinutes': serializer.toJson<int?>(actualMinutes),
      'priorityScore': serializer.toJson<int>(priorityScore),
      'isLocked': serializer.toJson<bool>(isLocked),
      'status': serializer.toJson<String>(status),
      'completionPercent': serializer.toJson<int>(completionPercent),
      'source': serializer.toJson<String>(source),
      'generationBatchId': serializer.toJson<String?>(generationBatchId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  StudyTaskRow copyWith({
    String? id,
    String? studyPlanId,
    String? subjectId,
    Value<String?> chapterId = const Value.absent(),
    Value<String?> topicId = const Value.absent(),
    Value<String?> examId = const Value.absent(),
    String? taskType,
    String? title,
    DateTime? plannedDate,
    Value<int?> plannedStartTime = const Value.absent(),
    int? plannedMinutes,
    Value<int?> actualMinutes = const Value.absent(),
    int? priorityScore,
    bool? isLocked,
    String? status,
    int? completionPercent,
    String? source,
    Value<String?> generationBatchId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => StudyTaskRow(
    id: id ?? this.id,
    studyPlanId: studyPlanId ?? this.studyPlanId,
    subjectId: subjectId ?? this.subjectId,
    chapterId: chapterId.present ? chapterId.value : this.chapterId,
    topicId: topicId.present ? topicId.value : this.topicId,
    examId: examId.present ? examId.value : this.examId,
    taskType: taskType ?? this.taskType,
    title: title ?? this.title,
    plannedDate: plannedDate ?? this.plannedDate,
    plannedStartTime: plannedStartTime.present
        ? plannedStartTime.value
        : this.plannedStartTime,
    plannedMinutes: plannedMinutes ?? this.plannedMinutes,
    actualMinutes: actualMinutes.present
        ? actualMinutes.value
        : this.actualMinutes,
    priorityScore: priorityScore ?? this.priorityScore,
    isLocked: isLocked ?? this.isLocked,
    status: status ?? this.status,
    completionPercent: completionPercent ?? this.completionPercent,
    source: source ?? this.source,
    generationBatchId: generationBatchId.present
        ? generationBatchId.value
        : this.generationBatchId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  StudyTaskRow copyWithCompanion(StudyTasksCompanion data) {
    return StudyTaskRow(
      id: data.id.present ? data.id.value : this.id,
      studyPlanId: data.studyPlanId.present
          ? data.studyPlanId.value
          : this.studyPlanId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      examId: data.examId.present ? data.examId.value : this.examId,
      taskType: data.taskType.present ? data.taskType.value : this.taskType,
      title: data.title.present ? data.title.value : this.title,
      plannedDate: data.plannedDate.present
          ? data.plannedDate.value
          : this.plannedDate,
      plannedStartTime: data.plannedStartTime.present
          ? data.plannedStartTime.value
          : this.plannedStartTime,
      plannedMinutes: data.plannedMinutes.present
          ? data.plannedMinutes.value
          : this.plannedMinutes,
      actualMinutes: data.actualMinutes.present
          ? data.actualMinutes.value
          : this.actualMinutes,
      priorityScore: data.priorityScore.present
          ? data.priorityScore.value
          : this.priorityScore,
      isLocked: data.isLocked.present ? data.isLocked.value : this.isLocked,
      status: data.status.present ? data.status.value : this.status,
      completionPercent: data.completionPercent.present
          ? data.completionPercent.value
          : this.completionPercent,
      source: data.source.present ? data.source.value : this.source,
      generationBatchId: data.generationBatchId.present
          ? data.generationBatchId.value
          : this.generationBatchId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyTaskRow(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('subjectId: $subjectId, ')
          ..write('chapterId: $chapterId, ')
          ..write('topicId: $topicId, ')
          ..write('examId: $examId, ')
          ..write('taskType: $taskType, ')
          ..write('title: $title, ')
          ..write('plannedDate: $plannedDate, ')
          ..write('plannedStartTime: $plannedStartTime, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('actualMinutes: $actualMinutes, ')
          ..write('priorityScore: $priorityScore, ')
          ..write('isLocked: $isLocked, ')
          ..write('status: $status, ')
          ..write('completionPercent: $completionPercent, ')
          ..write('source: $source, ')
          ..write('generationBatchId: $generationBatchId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    studyPlanId,
    subjectId,
    chapterId,
    topicId,
    examId,
    taskType,
    title,
    plannedDate,
    plannedStartTime,
    plannedMinutes,
    actualMinutes,
    priorityScore,
    isLocked,
    status,
    completionPercent,
    source,
    generationBatchId,
    createdAt,
    updatedAt,
    completedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyTaskRow &&
          other.id == this.id &&
          other.studyPlanId == this.studyPlanId &&
          other.subjectId == this.subjectId &&
          other.chapterId == this.chapterId &&
          other.topicId == this.topicId &&
          other.examId == this.examId &&
          other.taskType == this.taskType &&
          other.title == this.title &&
          other.plannedDate == this.plannedDate &&
          other.plannedStartTime == this.plannedStartTime &&
          other.plannedMinutes == this.plannedMinutes &&
          other.actualMinutes == this.actualMinutes &&
          other.priorityScore == this.priorityScore &&
          other.isLocked == this.isLocked &&
          other.status == this.status &&
          other.completionPercent == this.completionPercent &&
          other.source == this.source &&
          other.generationBatchId == this.generationBatchId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt);
}

class StudyTasksCompanion extends UpdateCompanion<StudyTaskRow> {
  final Value<String> id;
  final Value<String> studyPlanId;
  final Value<String> subjectId;
  final Value<String?> chapterId;
  final Value<String?> topicId;
  final Value<String?> examId;
  final Value<String> taskType;
  final Value<String> title;
  final Value<DateTime> plannedDate;
  final Value<int?> plannedStartTime;
  final Value<int> plannedMinutes;
  final Value<int?> actualMinutes;
  final Value<int> priorityScore;
  final Value<bool> isLocked;
  final Value<String> status;
  final Value<int> completionPercent;
  final Value<String> source;
  final Value<String?> generationBatchId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const StudyTasksCompanion({
    this.id = const Value.absent(),
    this.studyPlanId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.examId = const Value.absent(),
    this.taskType = const Value.absent(),
    this.title = const Value.absent(),
    this.plannedDate = const Value.absent(),
    this.plannedStartTime = const Value.absent(),
    this.plannedMinutes = const Value.absent(),
    this.actualMinutes = const Value.absent(),
    this.priorityScore = const Value.absent(),
    this.isLocked = const Value.absent(),
    this.status = const Value.absent(),
    this.completionPercent = const Value.absent(),
    this.source = const Value.absent(),
    this.generationBatchId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyTasksCompanion.insert({
    required String id,
    required String studyPlanId,
    required String subjectId,
    this.chapterId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.examId = const Value.absent(),
    required String taskType,
    required String title,
    required DateTime plannedDate,
    this.plannedStartTime = const Value.absent(),
    required int plannedMinutes,
    this.actualMinutes = const Value.absent(),
    required int priorityScore,
    required bool isLocked,
    required String status,
    required int completionPercent,
    required String source,
    this.generationBatchId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studyPlanId = Value(studyPlanId),
       subjectId = Value(subjectId),
       taskType = Value(taskType),
       title = Value(title),
       plannedDate = Value(plannedDate),
       plannedMinutes = Value(plannedMinutes),
       priorityScore = Value(priorityScore),
       isLocked = Value(isLocked),
       status = Value(status),
       completionPercent = Value(completionPercent),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<StudyTaskRow> custom({
    Expression<String>? id,
    Expression<String>? studyPlanId,
    Expression<String>? subjectId,
    Expression<String>? chapterId,
    Expression<String>? topicId,
    Expression<String>? examId,
    Expression<String>? taskType,
    Expression<String>? title,
    Expression<DateTime>? plannedDate,
    Expression<int>? plannedStartTime,
    Expression<int>? plannedMinutes,
    Expression<int>? actualMinutes,
    Expression<int>? priorityScore,
    Expression<bool>? isLocked,
    Expression<String>? status,
    Expression<int>? completionPercent,
    Expression<String>? source,
    Expression<String>? generationBatchId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studyPlanId != null) 'study_plan_id': studyPlanId,
      if (subjectId != null) 'subject_id': subjectId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (topicId != null) 'topic_id': topicId,
      if (examId != null) 'exam_id': examId,
      if (taskType != null) 'task_type': taskType,
      if (title != null) 'title': title,
      if (plannedDate != null) 'planned_date': plannedDate,
      if (plannedStartTime != null) 'planned_start_time': plannedStartTime,
      if (plannedMinutes != null) 'planned_minutes': plannedMinutes,
      if (actualMinutes != null) 'actual_minutes': actualMinutes,
      if (priorityScore != null) 'priority_score': priorityScore,
      if (isLocked != null) 'is_locked': isLocked,
      if (status != null) 'status': status,
      if (completionPercent != null) 'completion_percent': completionPercent,
      if (source != null) 'source': source,
      if (generationBatchId != null) 'generation_batch_id': generationBatchId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyTasksCompanion copyWith({
    Value<String>? id,
    Value<String>? studyPlanId,
    Value<String>? subjectId,
    Value<String?>? chapterId,
    Value<String?>? topicId,
    Value<String?>? examId,
    Value<String>? taskType,
    Value<String>? title,
    Value<DateTime>? plannedDate,
    Value<int?>? plannedStartTime,
    Value<int>? plannedMinutes,
    Value<int?>? actualMinutes,
    Value<int>? priorityScore,
    Value<bool>? isLocked,
    Value<String>? status,
    Value<int>? completionPercent,
    Value<String>? source,
    Value<String?>? generationBatchId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return StudyTasksCompanion(
      id: id ?? this.id,
      studyPlanId: studyPlanId ?? this.studyPlanId,
      subjectId: subjectId ?? this.subjectId,
      chapterId: chapterId ?? this.chapterId,
      topicId: topicId ?? this.topicId,
      examId: examId ?? this.examId,
      taskType: taskType ?? this.taskType,
      title: title ?? this.title,
      plannedDate: plannedDate ?? this.plannedDate,
      plannedStartTime: plannedStartTime ?? this.plannedStartTime,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      actualMinutes: actualMinutes ?? this.actualMinutes,
      priorityScore: priorityScore ?? this.priorityScore,
      isLocked: isLocked ?? this.isLocked,
      status: status ?? this.status,
      completionPercent: completionPercent ?? this.completionPercent,
      source: source ?? this.source,
      generationBatchId: generationBatchId ?? this.generationBatchId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studyPlanId.present) {
      map['study_plan_id'] = Variable<String>(studyPlanId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<String>(examId.value);
    }
    if (taskType.present) {
      map['task_type'] = Variable<String>(taskType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (plannedDate.present) {
      map['planned_date'] = Variable<DateTime>(plannedDate.value);
    }
    if (plannedStartTime.present) {
      map['planned_start_time'] = Variable<int>(plannedStartTime.value);
    }
    if (plannedMinutes.present) {
      map['planned_minutes'] = Variable<int>(plannedMinutes.value);
    }
    if (actualMinutes.present) {
      map['actual_minutes'] = Variable<int>(actualMinutes.value);
    }
    if (priorityScore.present) {
      map['priority_score'] = Variable<int>(priorityScore.value);
    }
    if (isLocked.present) {
      map['is_locked'] = Variable<bool>(isLocked.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (completionPercent.present) {
      map['completion_percent'] = Variable<int>(completionPercent.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (generationBatchId.present) {
      map['generation_batch_id'] = Variable<String>(generationBatchId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyTasksCompanion(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('subjectId: $subjectId, ')
          ..write('chapterId: $chapterId, ')
          ..write('topicId: $topicId, ')
          ..write('examId: $examId, ')
          ..write('taskType: $taskType, ')
          ..write('title: $title, ')
          ..write('plannedDate: $plannedDate, ')
          ..write('plannedStartTime: $plannedStartTime, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('actualMinutes: $actualMinutes, ')
          ..write('priorityScore: $priorityScore, ')
          ..write('isLocked: $isLocked, ')
          ..write('status: $status, ')
          ..write('completionPercent: $completionPercent, ')
          ..write('source: $source, ')
          ..write('generationBatchId: $generationBatchId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudySessionsTable extends StudySessions
    with TableInfo<$StudySessionsTable, StudySessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudySessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyTaskIdMeta = const VerificationMeta(
    'studyTaskId',
  );
  @override
  late final GeneratedColumn<String> studyTaskId = GeneratedColumn<String>(
    'study_task_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_tasks (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plannedMinutesMeta = const VerificationMeta(
    'plannedMinutes',
  );
  @override
  late final GeneratedColumn<int> plannedMinutes = GeneratedColumn<int>(
    'planned_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualMinutesMeta = const VerificationMeta(
    'actualMinutes',
  );
  @override
  late final GeneratedColumn<int> actualMinutes = GeneratedColumn<int>(
    'actual_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completionPercentMeta = const VerificationMeta(
    'completionPercent',
  );
  @override
  late final GeneratedColumn<int> completionPercent = GeneratedColumn<int>(
    'completion_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceBeforeMeta = const VerificationMeta(
    'confidenceBefore',
  );
  @override
  late final GeneratedColumn<String> confidenceBefore = GeneratedColumn<String>(
    'confidence_before',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceAfterMeta = const VerificationMeta(
    'confidenceAfter',
  );
  @override
  late final GeneratedColumn<String> confidenceAfter = GeneratedColumn<String>(
    'confidence_after',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studyTaskId,
    subjectId,
    chapterId,
    topicId,
    startedAt,
    endedAt,
    plannedMinutes,
    actualMinutes,
    completionPercent,
    result,
    confidenceBefore,
    confidenceAfter,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudySessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('study_task_id')) {
      context.handle(
        _studyTaskIdMeta,
        studyTaskId.isAcceptableOrUnknown(
          data['study_task_id']!,
          _studyTaskIdMeta,
        ),
      );
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('planned_minutes')) {
      context.handle(
        _plannedMinutesMeta,
        plannedMinutes.isAcceptableOrUnknown(
          data['planned_minutes']!,
          _plannedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedMinutesMeta);
    }
    if (data.containsKey('actual_minutes')) {
      context.handle(
        _actualMinutesMeta,
        actualMinutes.isAcceptableOrUnknown(
          data['actual_minutes']!,
          _actualMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualMinutesMeta);
    }
    if (data.containsKey('completion_percent')) {
      context.handle(
        _completionPercentMeta,
        completionPercent.isAcceptableOrUnknown(
          data['completion_percent']!,
          _completionPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completionPercentMeta);
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('confidence_before')) {
      context.handle(
        _confidenceBeforeMeta,
        confidenceBefore.isAcceptableOrUnknown(
          data['confidence_before']!,
          _confidenceBeforeMeta,
        ),
      );
    }
    if (data.containsKey('confidence_after')) {
      context.handle(
        _confidenceAfterMeta,
        confidenceAfter.isAcceptableOrUnknown(
          data['confidence_after']!,
          _confidenceAfterMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudySessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudySessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studyTaskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_task_id'],
      ),
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      ),
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      plannedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_minutes'],
      )!,
      actualMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_minutes'],
      )!,
      completionPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completion_percent'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      )!,
      confidenceBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confidence_before'],
      ),
      confidenceAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confidence_after'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StudySessionsTable createAlias(String alias) {
    return $StudySessionsTable(attachedDatabase, alias);
  }
}

class StudySessionRow extends DataClass implements Insertable<StudySessionRow> {
  final String id;

  /// History survives task deletion. Subject and chapter deletes are blocked
  /// until the caller explicitly removes history.
  final String? studyTaskId;
  final String subjectId;
  final String? chapterId;
  final String? topicId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int plannedMinutes;
  final int actualMinutes;
  final int completionPercent;
  final String result;
  final String? confidenceBefore;
  final String? confidenceAfter;
  final String? note;
  final DateTime createdAt;
  const StudySessionRow({
    required this.id,
    this.studyTaskId,
    required this.subjectId,
    this.chapterId,
    this.topicId,
    required this.startedAt,
    this.endedAt,
    required this.plannedMinutes,
    required this.actualMinutes,
    required this.completionPercent,
    required this.result,
    this.confidenceBefore,
    this.confidenceAfter,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || studyTaskId != null) {
      map['study_task_id'] = Variable<String>(studyTaskId);
    }
    map['subject_id'] = Variable<String>(subjectId);
    if (!nullToAbsent || chapterId != null) {
      map['chapter_id'] = Variable<String>(chapterId);
    }
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<String>(topicId);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['planned_minutes'] = Variable<int>(plannedMinutes);
    map['actual_minutes'] = Variable<int>(actualMinutes);
    map['completion_percent'] = Variable<int>(completionPercent);
    map['result'] = Variable<String>(result);
    if (!nullToAbsent || confidenceBefore != null) {
      map['confidence_before'] = Variable<String>(confidenceBefore);
    }
    if (!nullToAbsent || confidenceAfter != null) {
      map['confidence_after'] = Variable<String>(confidenceAfter);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StudySessionsCompanion toCompanion(bool nullToAbsent) {
    return StudySessionsCompanion(
      id: Value(id),
      studyTaskId: studyTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(studyTaskId),
      subjectId: Value(subjectId),
      chapterId: chapterId == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterId),
      topicId: topicId == null && nullToAbsent
          ? const Value.absent()
          : Value(topicId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      plannedMinutes: Value(plannedMinutes),
      actualMinutes: Value(actualMinutes),
      completionPercent: Value(completionPercent),
      result: Value(result),
      confidenceBefore: confidenceBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(confidenceBefore),
      confidenceAfter: confidenceAfter == null && nullToAbsent
          ? const Value.absent()
          : Value(confidenceAfter),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory StudySessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudySessionRow(
      id: serializer.fromJson<String>(json['id']),
      studyTaskId: serializer.fromJson<String?>(json['studyTaskId']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      chapterId: serializer.fromJson<String?>(json['chapterId']),
      topicId: serializer.fromJson<String?>(json['topicId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      plannedMinutes: serializer.fromJson<int>(json['plannedMinutes']),
      actualMinutes: serializer.fromJson<int>(json['actualMinutes']),
      completionPercent: serializer.fromJson<int>(json['completionPercent']),
      result: serializer.fromJson<String>(json['result']),
      confidenceBefore: serializer.fromJson<String?>(json['confidenceBefore']),
      confidenceAfter: serializer.fromJson<String?>(json['confidenceAfter']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studyTaskId': serializer.toJson<String?>(studyTaskId),
      'subjectId': serializer.toJson<String>(subjectId),
      'chapterId': serializer.toJson<String?>(chapterId),
      'topicId': serializer.toJson<String?>(topicId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'plannedMinutes': serializer.toJson<int>(plannedMinutes),
      'actualMinutes': serializer.toJson<int>(actualMinutes),
      'completionPercent': serializer.toJson<int>(completionPercent),
      'result': serializer.toJson<String>(result),
      'confidenceBefore': serializer.toJson<String?>(confidenceBefore),
      'confidenceAfter': serializer.toJson<String?>(confidenceAfter),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StudySessionRow copyWith({
    String? id,
    Value<String?> studyTaskId = const Value.absent(),
    String? subjectId,
    Value<String?> chapterId = const Value.absent(),
    Value<String?> topicId = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    int? plannedMinutes,
    int? actualMinutes,
    int? completionPercent,
    String? result,
    Value<String?> confidenceBefore = const Value.absent(),
    Value<String?> confidenceAfter = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => StudySessionRow(
    id: id ?? this.id,
    studyTaskId: studyTaskId.present ? studyTaskId.value : this.studyTaskId,
    subjectId: subjectId ?? this.subjectId,
    chapterId: chapterId.present ? chapterId.value : this.chapterId,
    topicId: topicId.present ? topicId.value : this.topicId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    plannedMinutes: plannedMinutes ?? this.plannedMinutes,
    actualMinutes: actualMinutes ?? this.actualMinutes,
    completionPercent: completionPercent ?? this.completionPercent,
    result: result ?? this.result,
    confidenceBefore: confidenceBefore.present
        ? confidenceBefore.value
        : this.confidenceBefore,
    confidenceAfter: confidenceAfter.present
        ? confidenceAfter.value
        : this.confidenceAfter,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  StudySessionRow copyWithCompanion(StudySessionsCompanion data) {
    return StudySessionRow(
      id: data.id.present ? data.id.value : this.id,
      studyTaskId: data.studyTaskId.present
          ? data.studyTaskId.value
          : this.studyTaskId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      plannedMinutes: data.plannedMinutes.present
          ? data.plannedMinutes.value
          : this.plannedMinutes,
      actualMinutes: data.actualMinutes.present
          ? data.actualMinutes.value
          : this.actualMinutes,
      completionPercent: data.completionPercent.present
          ? data.completionPercent.value
          : this.completionPercent,
      result: data.result.present ? data.result.value : this.result,
      confidenceBefore: data.confidenceBefore.present
          ? data.confidenceBefore.value
          : this.confidenceBefore,
      confidenceAfter: data.confidenceAfter.present
          ? data.confidenceAfter.value
          : this.confidenceAfter,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionRow(')
          ..write('id: $id, ')
          ..write('studyTaskId: $studyTaskId, ')
          ..write('subjectId: $subjectId, ')
          ..write('chapterId: $chapterId, ')
          ..write('topicId: $topicId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('actualMinutes: $actualMinutes, ')
          ..write('completionPercent: $completionPercent, ')
          ..write('result: $result, ')
          ..write('confidenceBefore: $confidenceBefore, ')
          ..write('confidenceAfter: $confidenceAfter, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studyTaskId,
    subjectId,
    chapterId,
    topicId,
    startedAt,
    endedAt,
    plannedMinutes,
    actualMinutes,
    completionPercent,
    result,
    confidenceBefore,
    confidenceAfter,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudySessionRow &&
          other.id == this.id &&
          other.studyTaskId == this.studyTaskId &&
          other.subjectId == this.subjectId &&
          other.chapterId == this.chapterId &&
          other.topicId == this.topicId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.plannedMinutes == this.plannedMinutes &&
          other.actualMinutes == this.actualMinutes &&
          other.completionPercent == this.completionPercent &&
          other.result == this.result &&
          other.confidenceBefore == this.confidenceBefore &&
          other.confidenceAfter == this.confidenceAfter &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class StudySessionsCompanion extends UpdateCompanion<StudySessionRow> {
  final Value<String> id;
  final Value<String?> studyTaskId;
  final Value<String> subjectId;
  final Value<String?> chapterId;
  final Value<String?> topicId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> plannedMinutes;
  final Value<int> actualMinutes;
  final Value<int> completionPercent;
  final Value<String> result;
  final Value<String?> confidenceBefore;
  final Value<String?> confidenceAfter;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StudySessionsCompanion({
    this.id = const Value.absent(),
    this.studyTaskId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.plannedMinutes = const Value.absent(),
    this.actualMinutes = const Value.absent(),
    this.completionPercent = const Value.absent(),
    this.result = const Value.absent(),
    this.confidenceBefore = const Value.absent(),
    this.confidenceAfter = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudySessionsCompanion.insert({
    required String id,
    this.studyTaskId = const Value.absent(),
    required String subjectId,
    this.chapterId = const Value.absent(),
    this.topicId = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required int plannedMinutes,
    required int actualMinutes,
    required int completionPercent,
    required String result,
    this.confidenceBefore = const Value.absent(),
    this.confidenceAfter = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subjectId = Value(subjectId),
       startedAt = Value(startedAt),
       plannedMinutes = Value(plannedMinutes),
       actualMinutes = Value(actualMinutes),
       completionPercent = Value(completionPercent),
       result = Value(result),
       createdAt = Value(createdAt);
  static Insertable<StudySessionRow> custom({
    Expression<String>? id,
    Expression<String>? studyTaskId,
    Expression<String>? subjectId,
    Expression<String>? chapterId,
    Expression<String>? topicId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? plannedMinutes,
    Expression<int>? actualMinutes,
    Expression<int>? completionPercent,
    Expression<String>? result,
    Expression<String>? confidenceBefore,
    Expression<String>? confidenceAfter,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studyTaskId != null) 'study_task_id': studyTaskId,
      if (subjectId != null) 'subject_id': subjectId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (topicId != null) 'topic_id': topicId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (plannedMinutes != null) 'planned_minutes': plannedMinutes,
      if (actualMinutes != null) 'actual_minutes': actualMinutes,
      if (completionPercent != null) 'completion_percent': completionPercent,
      if (result != null) 'result': result,
      if (confidenceBefore != null) 'confidence_before': confidenceBefore,
      if (confidenceAfter != null) 'confidence_after': confidenceAfter,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudySessionsCompanion copyWith({
    Value<String>? id,
    Value<String?>? studyTaskId,
    Value<String>? subjectId,
    Value<String?>? chapterId,
    Value<String?>? topicId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? plannedMinutes,
    Value<int>? actualMinutes,
    Value<int>? completionPercent,
    Value<String>? result,
    Value<String?>? confidenceBefore,
    Value<String?>? confidenceAfter,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return StudySessionsCompanion(
      id: id ?? this.id,
      studyTaskId: studyTaskId ?? this.studyTaskId,
      subjectId: subjectId ?? this.subjectId,
      chapterId: chapterId ?? this.chapterId,
      topicId: topicId ?? this.topicId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      actualMinutes: actualMinutes ?? this.actualMinutes,
      completionPercent: completionPercent ?? this.completionPercent,
      result: result ?? this.result,
      confidenceBefore: confidenceBefore ?? this.confidenceBefore,
      confidenceAfter: confidenceAfter ?? this.confidenceAfter,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studyTaskId.present) {
      map['study_task_id'] = Variable<String>(studyTaskId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (plannedMinutes.present) {
      map['planned_minutes'] = Variable<int>(plannedMinutes.value);
    }
    if (actualMinutes.present) {
      map['actual_minutes'] = Variable<int>(actualMinutes.value);
    }
    if (completionPercent.present) {
      map['completion_percent'] = Variable<int>(completionPercent.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (confidenceBefore.present) {
      map['confidence_before'] = Variable<String>(confidenceBefore.value);
    }
    if (confidenceAfter.present) {
      map['confidence_after'] = Variable<String>(confidenceAfter.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionsCompanion(')
          ..write('id: $id, ')
          ..write('studyTaskId: $studyTaskId, ')
          ..write('subjectId: $subjectId, ')
          ..write('chapterId: $chapterId, ')
          ..write('topicId: $topicId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('actualMinutes: $actualMinutes, ')
          ..write('completionPercent: $completionPercent, ')
          ..write('result: $result, ')
          ..write('confidenceBefore: $confidenceBefore, ')
          ..write('confidenceAfter: $confidenceAfter, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RevisionSchedulesTable extends RevisionSchedules
    with TableInfo<$RevisionSchedulesTable, RevisionScheduleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RevisionSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyPlanIdMeta = const VerificationMeta(
    'studyPlanId',
  );
  @override
  late final GeneratedColumn<String> studyPlanId = GeneratedColumn<String>(
    'study_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceStudySessionIdMeta =
      const VerificationMeta('sourceStudySessionId');
  @override
  late final GeneratedColumn<String> sourceStudySessionId =
      GeneratedColumn<String>(
        'source_study_session_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES study_sessions (id) ON DELETE SET NULL',
        ),
      );
  static const VerificationMeta _revisionNumberMeta = const VerificationMeta(
    'revisionNumber',
  );
  @override
  late final GeneratedColumn<int> revisionNumber = GeneratedColumn<int>(
    'revision_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studyPlanId,
    chapterId,
    topicId,
    sourceStudySessionId,
    revisionNumber,
    dueDate,
    estimatedMinutes,
    status,
    completedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'revision_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RevisionScheduleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('study_plan_id')) {
      context.handle(
        _studyPlanIdMeta,
        studyPlanId.isAcceptableOrUnknown(
          data['study_plan_id']!,
          _studyPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyPlanIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('source_study_session_id')) {
      context.handle(
        _sourceStudySessionIdMeta,
        sourceStudySessionId.isAcceptableOrUnknown(
          data['source_study_session_id']!,
          _sourceStudySessionIdMeta,
        ),
      );
    }
    if (data.containsKey('revision_number')) {
      context.handle(
        _revisionNumberMeta,
        revisionNumber.isAcceptableOrUnknown(
          data['revision_number']!,
          _revisionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_revisionNumberMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedMinutesMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RevisionScheduleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RevisionScheduleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studyPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_plan_id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      ),
      sourceStudySessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_study_session_id'],
      ),
      revisionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision_number'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RevisionSchedulesTable createAlias(String alias) {
    return $RevisionSchedulesTable(attachedDatabase, alias);
  }
}

class RevisionScheduleRow extends DataClass
    implements Insertable<RevisionScheduleRow> {
  final String id;
  final String studyPlanId;
  final String chapterId;
  final String? topicId;
  final String? sourceStudySessionId;
  final int revisionNumber;
  final DateTime dueDate;
  final int estimatedMinutes;
  final String status;
  final DateTime? completedAt;
  final DateTime createdAt;
  const RevisionScheduleRow({
    required this.id,
    required this.studyPlanId,
    required this.chapterId,
    this.topicId,
    this.sourceStudySessionId,
    required this.revisionNumber,
    required this.dueDate,
    required this.estimatedMinutes,
    required this.status,
    this.completedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['study_plan_id'] = Variable<String>(studyPlanId);
    map['chapter_id'] = Variable<String>(chapterId);
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<String>(topicId);
    }
    if (!nullToAbsent || sourceStudySessionId != null) {
      map['source_study_session_id'] = Variable<String>(sourceStudySessionId);
    }
    map['revision_number'] = Variable<int>(revisionNumber);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RevisionSchedulesCompanion toCompanion(bool nullToAbsent) {
    return RevisionSchedulesCompanion(
      id: Value(id),
      studyPlanId: Value(studyPlanId),
      chapterId: Value(chapterId),
      topicId: topicId == null && nullToAbsent
          ? const Value.absent()
          : Value(topicId),
      sourceStudySessionId: sourceStudySessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceStudySessionId),
      revisionNumber: Value(revisionNumber),
      dueDate: Value(dueDate),
      estimatedMinutes: Value(estimatedMinutes),
      status: Value(status),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
    );
  }

  factory RevisionScheduleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RevisionScheduleRow(
      id: serializer.fromJson<String>(json['id']),
      studyPlanId: serializer.fromJson<String>(json['studyPlanId']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      topicId: serializer.fromJson<String?>(json['topicId']),
      sourceStudySessionId: serializer.fromJson<String?>(
        json['sourceStudySessionId'],
      ),
      revisionNumber: serializer.fromJson<int>(json['revisionNumber']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      status: serializer.fromJson<String>(json['status']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studyPlanId': serializer.toJson<String>(studyPlanId),
      'chapterId': serializer.toJson<String>(chapterId),
      'topicId': serializer.toJson<String?>(topicId),
      'sourceStudySessionId': serializer.toJson<String?>(sourceStudySessionId),
      'revisionNumber': serializer.toJson<int>(revisionNumber),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'status': serializer.toJson<String>(status),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RevisionScheduleRow copyWith({
    String? id,
    String? studyPlanId,
    String? chapterId,
    Value<String?> topicId = const Value.absent(),
    Value<String?> sourceStudySessionId = const Value.absent(),
    int? revisionNumber,
    DateTime? dueDate,
    int? estimatedMinutes,
    String? status,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
  }) => RevisionScheduleRow(
    id: id ?? this.id,
    studyPlanId: studyPlanId ?? this.studyPlanId,
    chapterId: chapterId ?? this.chapterId,
    topicId: topicId.present ? topicId.value : this.topicId,
    sourceStudySessionId: sourceStudySessionId.present
        ? sourceStudySessionId.value
        : this.sourceStudySessionId,
    revisionNumber: revisionNumber ?? this.revisionNumber,
    dueDate: dueDate ?? this.dueDate,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    status: status ?? this.status,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  RevisionScheduleRow copyWithCompanion(RevisionSchedulesCompanion data) {
    return RevisionScheduleRow(
      id: data.id.present ? data.id.value : this.id,
      studyPlanId: data.studyPlanId.present
          ? data.studyPlanId.value
          : this.studyPlanId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      sourceStudySessionId: data.sourceStudySessionId.present
          ? data.sourceStudySessionId.value
          : this.sourceStudySessionId,
      revisionNumber: data.revisionNumber.present
          ? data.revisionNumber.value
          : this.revisionNumber,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      status: data.status.present ? data.status.value : this.status,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RevisionScheduleRow(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('chapterId: $chapterId, ')
          ..write('topicId: $topicId, ')
          ..write('sourceStudySessionId: $sourceStudySessionId, ')
          ..write('revisionNumber: $revisionNumber, ')
          ..write('dueDate: $dueDate, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studyPlanId,
    chapterId,
    topicId,
    sourceStudySessionId,
    revisionNumber,
    dueDate,
    estimatedMinutes,
    status,
    completedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RevisionScheduleRow &&
          other.id == this.id &&
          other.studyPlanId == this.studyPlanId &&
          other.chapterId == this.chapterId &&
          other.topicId == this.topicId &&
          other.sourceStudySessionId == this.sourceStudySessionId &&
          other.revisionNumber == this.revisionNumber &&
          other.dueDate == this.dueDate &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.status == this.status &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt);
}

class RevisionSchedulesCompanion extends UpdateCompanion<RevisionScheduleRow> {
  final Value<String> id;
  final Value<String> studyPlanId;
  final Value<String> chapterId;
  final Value<String?> topicId;
  final Value<String?> sourceStudySessionId;
  final Value<int> revisionNumber;
  final Value<DateTime> dueDate;
  final Value<int> estimatedMinutes;
  final Value<String> status;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RevisionSchedulesCompanion({
    this.id = const Value.absent(),
    this.studyPlanId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.sourceStudySessionId = const Value.absent(),
    this.revisionNumber = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RevisionSchedulesCompanion.insert({
    required String id,
    required String studyPlanId,
    required String chapterId,
    this.topicId = const Value.absent(),
    this.sourceStudySessionId = const Value.absent(),
    required int revisionNumber,
    required DateTime dueDate,
    required int estimatedMinutes,
    required String status,
    this.completedAt = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studyPlanId = Value(studyPlanId),
       chapterId = Value(chapterId),
       revisionNumber = Value(revisionNumber),
       dueDate = Value(dueDate),
       estimatedMinutes = Value(estimatedMinutes),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<RevisionScheduleRow> custom({
    Expression<String>? id,
    Expression<String>? studyPlanId,
    Expression<String>? chapterId,
    Expression<String>? topicId,
    Expression<String>? sourceStudySessionId,
    Expression<int>? revisionNumber,
    Expression<DateTime>? dueDate,
    Expression<int>? estimatedMinutes,
    Expression<String>? status,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studyPlanId != null) 'study_plan_id': studyPlanId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (topicId != null) 'topic_id': topicId,
      if (sourceStudySessionId != null)
        'source_study_session_id': sourceStudySessionId,
      if (revisionNumber != null) 'revision_number': revisionNumber,
      if (dueDate != null) 'due_date': dueDate,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (status != null) 'status': status,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RevisionSchedulesCompanion copyWith({
    Value<String>? id,
    Value<String>? studyPlanId,
    Value<String>? chapterId,
    Value<String?>? topicId,
    Value<String?>? sourceStudySessionId,
    Value<int>? revisionNumber,
    Value<DateTime>? dueDate,
    Value<int>? estimatedMinutes,
    Value<String>? status,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RevisionSchedulesCompanion(
      id: id ?? this.id,
      studyPlanId: studyPlanId ?? this.studyPlanId,
      chapterId: chapterId ?? this.chapterId,
      topicId: topicId ?? this.topicId,
      sourceStudySessionId: sourceStudySessionId ?? this.sourceStudySessionId,
      revisionNumber: revisionNumber ?? this.revisionNumber,
      dueDate: dueDate ?? this.dueDate,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studyPlanId.present) {
      map['study_plan_id'] = Variable<String>(studyPlanId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (sourceStudySessionId.present) {
      map['source_study_session_id'] = Variable<String>(
        sourceStudySessionId.value,
      );
    }
    if (revisionNumber.present) {
      map['revision_number'] = Variable<int>(revisionNumber.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RevisionSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('chapterId: $chapterId, ')
          ..write('topicId: $topicId, ')
          ..write('sourceStudySessionId: $sourceStudySessionId, ')
          ..write('revisionNumber: $revisionNumber, ')
          ..write('dueDate: $dueDate, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlannerRunsTable extends PlannerRuns
    with TableInfo<$PlannerRunsTable, PlannerRunRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlannerRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyPlanIdMeta = const VerificationMeta(
    'studyPlanId',
  );
  @override
  late final GeneratedColumn<String> studyPlanId = GeneratedColumn<String>(
    'study_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _triggerMeta = const VerificationMeta(
    'trigger',
  );
  @override
  late final GeneratedColumn<String> trigger = GeneratedColumn<String>(
    'trigger',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inputTaskCountMeta = const VerificationMeta(
    'inputTaskCount',
  );
  @override
  late final GeneratedColumn<int> inputTaskCount = GeneratedColumn<int>(
    'input_task_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outputTaskCountMeta = const VerificationMeta(
    'outputTaskCount',
  );
  @override
  late final GeneratedColumn<int> outputTaskCount = GeneratedColumn<int>(
    'output_task_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _riskLevelMeta = const VerificationMeta(
    'riskLevel',
  );
  @override
  late final GeneratedColumn<String> riskLevel = GeneratedColumn<String>(
    'risk_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedFinishDateMeta =
      const VerificationMeta('expectedFinishDate');
  @override
  late final GeneratedColumn<DateTime> expectedFinishDate =
      GeneratedColumn<DateTime>(
        'expected_finish_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _algorithmVersionMeta = const VerificationMeta(
    'algorithmVersion',
  );
  @override
  late final GeneratedColumn<String> algorithmVersion = GeneratedColumn<String>(
    'algorithm_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studyPlanId,
    trigger,
    startedAt,
    completedAt,
    inputTaskCount,
    outputTaskCount,
    riskLevel,
    expectedFinishDate,
    algorithmVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'planner_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlannerRunRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('study_plan_id')) {
      context.handle(
        _studyPlanIdMeta,
        studyPlanId.isAcceptableOrUnknown(
          data['study_plan_id']!,
          _studyPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_studyPlanIdMeta);
    }
    if (data.containsKey('trigger')) {
      context.handle(
        _triggerMeta,
        trigger.isAcceptableOrUnknown(data['trigger']!, _triggerMeta),
      );
    } else if (isInserting) {
      context.missing(_triggerMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('input_task_count')) {
      context.handle(
        _inputTaskCountMeta,
        inputTaskCount.isAcceptableOrUnknown(
          data['input_task_count']!,
          _inputTaskCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inputTaskCountMeta);
    }
    if (data.containsKey('output_task_count')) {
      context.handle(
        _outputTaskCountMeta,
        outputTaskCount.isAcceptableOrUnknown(
          data['output_task_count']!,
          _outputTaskCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_outputTaskCountMeta);
    }
    if (data.containsKey('risk_level')) {
      context.handle(
        _riskLevelMeta,
        riskLevel.isAcceptableOrUnknown(data['risk_level']!, _riskLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_riskLevelMeta);
    }
    if (data.containsKey('expected_finish_date')) {
      context.handle(
        _expectedFinishDateMeta,
        expectedFinishDate.isAcceptableOrUnknown(
          data['expected_finish_date']!,
          _expectedFinishDateMeta,
        ),
      );
    }
    if (data.containsKey('algorithm_version')) {
      context.handle(
        _algorithmVersionMeta,
        algorithmVersion.isAcceptableOrUnknown(
          data['algorithm_version']!,
          _algorithmVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_algorithmVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlannerRunRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlannerRunRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      studyPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_plan_id'],
      )!,
      trigger: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      inputTaskCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}input_task_count'],
      )!,
      outputTaskCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}output_task_count'],
      )!,
      riskLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}risk_level'],
      )!,
      expectedFinishDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_finish_date'],
      ),
      algorithmVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}algorithm_version'],
      )!,
    );
  }

  @override
  $PlannerRunsTable createAlias(String alias) {
    return $PlannerRunsTable(attachedDatabase, alias);
  }
}

class PlannerRunRow extends DataClass implements Insertable<PlannerRunRow> {
  final String id;
  final String studyPlanId;
  final String trigger;
  final DateTime startedAt;
  final DateTime? completedAt;
  final int inputTaskCount;
  final int outputTaskCount;
  final String riskLevel;
  final DateTime? expectedFinishDate;
  final String algorithmVersion;
  const PlannerRunRow({
    required this.id,
    required this.studyPlanId,
    required this.trigger,
    required this.startedAt,
    this.completedAt,
    required this.inputTaskCount,
    required this.outputTaskCount,
    required this.riskLevel,
    this.expectedFinishDate,
    required this.algorithmVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['study_plan_id'] = Variable<String>(studyPlanId);
    map['trigger'] = Variable<String>(trigger);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['input_task_count'] = Variable<int>(inputTaskCount);
    map['output_task_count'] = Variable<int>(outputTaskCount);
    map['risk_level'] = Variable<String>(riskLevel);
    if (!nullToAbsent || expectedFinishDate != null) {
      map['expected_finish_date'] = Variable<DateTime>(expectedFinishDate);
    }
    map['algorithm_version'] = Variable<String>(algorithmVersion);
    return map;
  }

  PlannerRunsCompanion toCompanion(bool nullToAbsent) {
    return PlannerRunsCompanion(
      id: Value(id),
      studyPlanId: Value(studyPlanId),
      trigger: Value(trigger),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      inputTaskCount: Value(inputTaskCount),
      outputTaskCount: Value(outputTaskCount),
      riskLevel: Value(riskLevel),
      expectedFinishDate: expectedFinishDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedFinishDate),
      algorithmVersion: Value(algorithmVersion),
    );
  }

  factory PlannerRunRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlannerRunRow(
      id: serializer.fromJson<String>(json['id']),
      studyPlanId: serializer.fromJson<String>(json['studyPlanId']),
      trigger: serializer.fromJson<String>(json['trigger']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      inputTaskCount: serializer.fromJson<int>(json['inputTaskCount']),
      outputTaskCount: serializer.fromJson<int>(json['outputTaskCount']),
      riskLevel: serializer.fromJson<String>(json['riskLevel']),
      expectedFinishDate: serializer.fromJson<DateTime?>(
        json['expectedFinishDate'],
      ),
      algorithmVersion: serializer.fromJson<String>(json['algorithmVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'studyPlanId': serializer.toJson<String>(studyPlanId),
      'trigger': serializer.toJson<String>(trigger),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'inputTaskCount': serializer.toJson<int>(inputTaskCount),
      'outputTaskCount': serializer.toJson<int>(outputTaskCount),
      'riskLevel': serializer.toJson<String>(riskLevel),
      'expectedFinishDate': serializer.toJson<DateTime?>(expectedFinishDate),
      'algorithmVersion': serializer.toJson<String>(algorithmVersion),
    };
  }

  PlannerRunRow copyWith({
    String? id,
    String? studyPlanId,
    String? trigger,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    int? inputTaskCount,
    int? outputTaskCount,
    String? riskLevel,
    Value<DateTime?> expectedFinishDate = const Value.absent(),
    String? algorithmVersion,
  }) => PlannerRunRow(
    id: id ?? this.id,
    studyPlanId: studyPlanId ?? this.studyPlanId,
    trigger: trigger ?? this.trigger,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    inputTaskCount: inputTaskCount ?? this.inputTaskCount,
    outputTaskCount: outputTaskCount ?? this.outputTaskCount,
    riskLevel: riskLevel ?? this.riskLevel,
    expectedFinishDate: expectedFinishDate.present
        ? expectedFinishDate.value
        : this.expectedFinishDate,
    algorithmVersion: algorithmVersion ?? this.algorithmVersion,
  );
  PlannerRunRow copyWithCompanion(PlannerRunsCompanion data) {
    return PlannerRunRow(
      id: data.id.present ? data.id.value : this.id,
      studyPlanId: data.studyPlanId.present
          ? data.studyPlanId.value
          : this.studyPlanId,
      trigger: data.trigger.present ? data.trigger.value : this.trigger,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      inputTaskCount: data.inputTaskCount.present
          ? data.inputTaskCount.value
          : this.inputTaskCount,
      outputTaskCount: data.outputTaskCount.present
          ? data.outputTaskCount.value
          : this.outputTaskCount,
      riskLevel: data.riskLevel.present ? data.riskLevel.value : this.riskLevel,
      expectedFinishDate: data.expectedFinishDate.present
          ? data.expectedFinishDate.value
          : this.expectedFinishDate,
      algorithmVersion: data.algorithmVersion.present
          ? data.algorithmVersion.value
          : this.algorithmVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlannerRunRow(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('trigger: $trigger, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('inputTaskCount: $inputTaskCount, ')
          ..write('outputTaskCount: $outputTaskCount, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('expectedFinishDate: $expectedFinishDate, ')
          ..write('algorithmVersion: $algorithmVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studyPlanId,
    trigger,
    startedAt,
    completedAt,
    inputTaskCount,
    outputTaskCount,
    riskLevel,
    expectedFinishDate,
    algorithmVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlannerRunRow &&
          other.id == this.id &&
          other.studyPlanId == this.studyPlanId &&
          other.trigger == this.trigger &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.inputTaskCount == this.inputTaskCount &&
          other.outputTaskCount == this.outputTaskCount &&
          other.riskLevel == this.riskLevel &&
          other.expectedFinishDate == this.expectedFinishDate &&
          other.algorithmVersion == this.algorithmVersion);
}

class PlannerRunsCompanion extends UpdateCompanion<PlannerRunRow> {
  final Value<String> id;
  final Value<String> studyPlanId;
  final Value<String> trigger;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> inputTaskCount;
  final Value<int> outputTaskCount;
  final Value<String> riskLevel;
  final Value<DateTime?> expectedFinishDate;
  final Value<String> algorithmVersion;
  final Value<int> rowid;
  const PlannerRunsCompanion({
    this.id = const Value.absent(),
    this.studyPlanId = const Value.absent(),
    this.trigger = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.inputTaskCount = const Value.absent(),
    this.outputTaskCount = const Value.absent(),
    this.riskLevel = const Value.absent(),
    this.expectedFinishDate = const Value.absent(),
    this.algorithmVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlannerRunsCompanion.insert({
    required String id,
    required String studyPlanId,
    required String trigger,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    required int inputTaskCount,
    required int outputTaskCount,
    required String riskLevel,
    this.expectedFinishDate = const Value.absent(),
    required String algorithmVersion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       studyPlanId = Value(studyPlanId),
       trigger = Value(trigger),
       startedAt = Value(startedAt),
       inputTaskCount = Value(inputTaskCount),
       outputTaskCount = Value(outputTaskCount),
       riskLevel = Value(riskLevel),
       algorithmVersion = Value(algorithmVersion);
  static Insertable<PlannerRunRow> custom({
    Expression<String>? id,
    Expression<String>? studyPlanId,
    Expression<String>? trigger,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? inputTaskCount,
    Expression<int>? outputTaskCount,
    Expression<String>? riskLevel,
    Expression<DateTime>? expectedFinishDate,
    Expression<String>? algorithmVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studyPlanId != null) 'study_plan_id': studyPlanId,
      if (trigger != null) 'trigger': trigger,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (inputTaskCount != null) 'input_task_count': inputTaskCount,
      if (outputTaskCount != null) 'output_task_count': outputTaskCount,
      if (riskLevel != null) 'risk_level': riskLevel,
      if (expectedFinishDate != null)
        'expected_finish_date': expectedFinishDate,
      if (algorithmVersion != null) 'algorithm_version': algorithmVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlannerRunsCompanion copyWith({
    Value<String>? id,
    Value<String>? studyPlanId,
    Value<String>? trigger,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<int>? inputTaskCount,
    Value<int>? outputTaskCount,
    Value<String>? riskLevel,
    Value<DateTime?>? expectedFinishDate,
    Value<String>? algorithmVersion,
    Value<int>? rowid,
  }) {
    return PlannerRunsCompanion(
      id: id ?? this.id,
      studyPlanId: studyPlanId ?? this.studyPlanId,
      trigger: trigger ?? this.trigger,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      inputTaskCount: inputTaskCount ?? this.inputTaskCount,
      outputTaskCount: outputTaskCount ?? this.outputTaskCount,
      riskLevel: riskLevel ?? this.riskLevel,
      expectedFinishDate: expectedFinishDate ?? this.expectedFinishDate,
      algorithmVersion: algorithmVersion ?? this.algorithmVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (studyPlanId.present) {
      map['study_plan_id'] = Variable<String>(studyPlanId.value);
    }
    if (trigger.present) {
      map['trigger'] = Variable<String>(trigger.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (inputTaskCount.present) {
      map['input_task_count'] = Variable<int>(inputTaskCount.value);
    }
    if (outputTaskCount.present) {
      map['output_task_count'] = Variable<int>(outputTaskCount.value);
    }
    if (riskLevel.present) {
      map['risk_level'] = Variable<String>(riskLevel.value);
    }
    if (expectedFinishDate.present) {
      map['expected_finish_date'] = Variable<DateTime>(
        expectedFinishDate.value,
      );
    }
    if (algorithmVersion.present) {
      map['algorithm_version'] = Variable<String>(algorithmVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlannerRunsCompanion(')
          ..write('id: $id, ')
          ..write('studyPlanId: $studyPlanId, ')
          ..write('trigger: $trigger, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('inputTaskCount: $inputTaskCount, ')
          ..write('outputTaskCount: $outputTaskCount, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('expectedFinishDate: $expectedFinishDate, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudentProfilesTable studentProfiles = $StudentProfilesTable(
    this,
  );
  late final $StudyPlansTable studyPlans = $StudyPlansTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  late final $ExamsTable exams = $ExamsTable(this);
  late final $ExamSyllabusItemsTable examSyllabusItems =
      $ExamSyllabusItemsTable(this);
  late final $WeeklyAvailabilitiesTable weeklyAvailabilities =
      $WeeklyAvailabilitiesTable(this);
  late final $CalendarExceptionsTable calendarExceptions =
      $CalendarExceptionsTable(this);
  late final $StudyTasksTable studyTasks = $StudyTasksTable(this);
  late final $StudySessionsTable studySessions = $StudySessionsTable(this);
  late final $RevisionSchedulesTable revisionSchedules =
      $RevisionSchedulesTable(this);
  late final $PlannerRunsTable plannerRuns = $PlannerRunsTable(this);
  late final Index idxSubjectsStudyPlanId = Index(
    'idx_subjects_study_plan_id',
    'CREATE INDEX idx_subjects_study_plan_id ON subjects (study_plan_id)',
  );
  late final Index idxChaptersSubjectIdStatus = Index(
    'idx_chapters_subject_id_status',
    'CREATE INDEX idx_chapters_subject_id_status ON chapters (subject_id, status)',
  );
  late final Index idxExamsStudyPlanIdStartDate = Index(
    'idx_exams_study_plan_id_start_date',
    'CREATE INDEX idx_exams_study_plan_id_start_date ON exams (study_plan_id, start_date)',
  );
  late final Index idxWeeklyAvailabilityStudyPlanIdWeekday = Index(
    'idx_weekly_availability_study_plan_id_weekday',
    'CREATE UNIQUE INDEX idx_weekly_availability_study_plan_id_weekday ON weekly_availability (study_plan_id, weekday)',
  );
  late final Index idxCalendarExceptionsStudyPlanIdDate = Index(
    'idx_calendar_exceptions_study_plan_id_date',
    'CREATE UNIQUE INDEX idx_calendar_exceptions_study_plan_id_date ON calendar_exceptions (study_plan_id, date)',
  );
  late final Index idxStudyTasksStudyPlanIdPlannedDate = Index(
    'idx_study_tasks_study_plan_id_planned_date',
    'CREATE INDEX idx_study_tasks_study_plan_id_planned_date ON study_tasks (study_plan_id, planned_date)',
  );
  late final Index idxStudyTasksStatusPlannedDate = Index(
    'idx_study_tasks_status_planned_date',
    'CREATE INDEX idx_study_tasks_status_planned_date ON study_tasks (status, planned_date)',
  );
  late final Index idxStudyTasksSubjectIdStatus = Index(
    'idx_study_tasks_subject_id_status',
    'CREATE INDEX idx_study_tasks_subject_id_status ON study_tasks (subject_id, status)',
  );
  late final Index idxStudyTasksChapterIdStatus = Index(
    'idx_study_tasks_chapter_id_status',
    'CREATE INDEX idx_study_tasks_chapter_id_status ON study_tasks (chapter_id, status)',
  );
  late final Index idxStudySessionsSubjectIdStartedAt = Index(
    'idx_study_sessions_subject_id_started_at',
    'CREATE INDEX idx_study_sessions_subject_id_started_at ON study_sessions (subject_id, started_at)',
  );
  late final Index idxStudySessionsStartedAt = Index(
    'idx_study_sessions_started_at',
    'CREATE INDEX idx_study_sessions_started_at ON study_sessions (started_at)',
  );
  late final Index idxRevisionSchedulesDueDateStatus = Index(
    'idx_revision_schedules_due_date_status',
    'CREATE INDEX idx_revision_schedules_due_date_status ON revision_schedules (due_date, status)',
  );
  late final Index idxRevisionSchedulesChapterIdStatus = Index(
    'idx_revision_schedules_chapter_id_status',
    'CREATE INDEX idx_revision_schedules_chapter_id_status ON revision_schedules (chapter_id, status)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    studentProfiles,
    studyPlans,
    subjects,
    chapters,
    exams,
    examSyllabusItems,
    weeklyAvailabilities,
    calendarExceptions,
    studyTasks,
    studySessions,
    revisionSchedules,
    plannerRuns,
    idxSubjectsStudyPlanId,
    idxChaptersSubjectIdStatus,
    idxExamsStudyPlanIdStartDate,
    idxWeeklyAvailabilityStudyPlanIdWeekday,
    idxCalendarExceptionsStudyPlanIdDate,
    idxStudyTasksStudyPlanIdPlannedDate,
    idxStudyTasksStatusPlannedDate,
    idxStudyTasksSubjectIdStatus,
    idxStudyTasksChapterIdStatus,
    idxStudySessionsSubjectIdStartedAt,
    idxStudySessionsStartedAt,
    idxRevisionSchedulesDueDateStatus,
    idxRevisionSchedulesChapterIdStatus,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('subjects', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chapters', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exams', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'exams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exam_syllabus_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exam_syllabus_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'chapters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exam_syllabus_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('weekly_availability', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('calendar_exceptions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_tasks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_tasks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'chapters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_tasks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'exams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_tasks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_tasks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('revision_schedules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'chapters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('revision_schedules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('revision_schedules', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('planner_runs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$StudentProfilesTableCreateCompanionBuilder =
    StudentProfilesCompanion Function({
      required String id,
      required String displayName,
      required String studyLevel,
      Value<String?> institution,
      Value<String?> academicYear,
      required String preferredLanguage,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$StudentProfilesTableUpdateCompanionBuilder =
    StudentProfilesCompanion Function({
      Value<String> id,
      Value<String> displayName,
      Value<String> studyLevel,
      Value<String?> institution,
      Value<String?> academicYear,
      Value<String> preferredLanguage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$StudentProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studyLevel => $composableBuilder(
    column: $table.studyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get institution => $composableBuilder(
    column: $table.institution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudentProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studyLevel => $composableBuilder(
    column: $table.studyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get institution => $composableBuilder(
    column: $table.institution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get studyLevel => $composableBuilder(
    column: $table.studyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get institution => $composableBuilder(
    column: $table.institution,
    builder: (column) => column,
  );

  GeneratedColumn<String> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StudentProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentProfilesTable,
          StudentProfileRow,
          $$StudentProfilesTableFilterComposer,
          $$StudentProfilesTableOrderingComposer,
          $$StudentProfilesTableAnnotationComposer,
          $$StudentProfilesTableCreateCompanionBuilder,
          $$StudentProfilesTableUpdateCompanionBuilder,
          (
            StudentProfileRow,
            BaseReferences<
              _$AppDatabase,
              $StudentProfilesTable,
              StudentProfileRow
            >,
          ),
          StudentProfileRow,
          PrefetchHooks Function()
        > {
  $$StudentProfilesTableTableManager(
    _$AppDatabase db,
    $StudentProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> studyLevel = const Value.absent(),
                Value<String?> institution = const Value.absent(),
                Value<String?> academicYear = const Value.absent(),
                Value<String> preferredLanguage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudentProfilesCompanion(
                id: id,
                displayName: displayName,
                studyLevel: studyLevel,
                institution: institution,
                academicYear: academicYear,
                preferredLanguage: preferredLanguage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String displayName,
                required String studyLevel,
                Value<String?> institution = const Value.absent(),
                Value<String?> academicYear = const Value.absent(),
                required String preferredLanguage,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => StudentProfilesCompanion.insert(
                id: id,
                displayName: displayName,
                studyLevel: studyLevel,
                institution: institution,
                academicYear: academicYear,
                preferredLanguage: preferredLanguage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudentProfilesTable, StudentProfileRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $StudentProfilesTable,
                    StudentProfileRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudentProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentProfilesTable,
      StudentProfileRow,
      $$StudentProfilesTableFilterComposer,
      $$StudentProfilesTableOrderingComposer,
      $$StudentProfilesTableAnnotationComposer,
      $$StudentProfilesTableCreateCompanionBuilder,
      $$StudentProfilesTableUpdateCompanionBuilder,
      (
        StudentProfileRow,
        BaseReferences<_$AppDatabase, $StudentProfilesTable, StudentProfileRow>,
      ),
      StudentProfileRow,
      PrefetchHooks Function()
    >;
typedef $$StudyPlansTableCreateCompanionBuilder = StudyPlansCompanion Function({
  required String id,
  required String name,
  Value<String?> description,
  required String planType,
  required String status,
  required DateTime startDate,
  Value<DateTime?> targetEndDate,
  Value<String?> primaryExamId,
  required String planningMode,
  required String dailyIntensity,
  required int maxDailyMinutes,
  required int maxSessionMinutes,
  required int planningBufferPercent,
  required int revisionBufferDays,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> archivedAt,
  Value<int> rowid,
});
typedef $$StudyPlansTableUpdateCompanionBuilder = StudyPlansCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<String> planType,
  Value<String> status,
  Value<DateTime> startDate,
  Value<DateTime?> targetEndDate,
  Value<String?> primaryExamId,
  Value<String> planningMode,
  Value<String> dailyIntensity,
  Value<int> maxDailyMinutes,
  Value<int> maxSessionMinutes,
  Value<int> planningBufferPercent,
  Value<int> revisionBufferDays,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> archivedAt,
  Value<int> rowid,
});

final class $$StudyPlansTableReferences
    extends BaseReferences<_$AppDatabase, $StudyPlansTable, StudyPlanRow> {
  $$StudyPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SubjectsTable, List<SubjectRow>>
  _subjectsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.subjects,
    aliasName: 'study_plans__id__subjects__study_plan_id',
  );

  $$SubjectsTableProcessedTableManager get subjectsRefs {
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.studyPlanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_subjectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExamsTable, List<ExamRow>> _examsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.exams,
    aliasName: 'study_plans__id__exams__study_plan_id',
  );

  $$ExamsTableProcessedTableManager get examsRefs {
    final manager = $$ExamsTableTableManager(
      $_db,
      $_db.exams,
    ).filter((f) => f.studyPlanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $WeeklyAvailabilitiesTable,
    List<WeeklyAvailabilityRow>
  >
  _weeklyAvailabilitiesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.weeklyAvailabilities,
        aliasName: 'study_plans__id__weekly_availability__study_plan_id',
      );

  $$WeeklyAvailabilitiesTableProcessedTableManager
  get weeklyAvailabilitiesRefs {
    final manager = $$WeeklyAvailabilitiesTableTableManager(
      $_db,
      $_db.weeklyAvailabilities,
    ).filter((f) => f.studyPlanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _weeklyAvailabilitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CalendarExceptionsTable,
    List<CalendarExceptionRow>
  >
  _calendarExceptionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.calendarExceptions,
        aliasName: 'study_plans__id__calendar_exceptions__study_plan_id',
      );

  $$CalendarExceptionsTableProcessedTableManager get calendarExceptionsRefs {
    final manager = $$CalendarExceptionsTableTableManager(
      $_db,
      $_db.calendarExceptions,
    ).filter((f) => f.studyPlanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _calendarExceptionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudyTasksTable, List<StudyTaskRow>>
  _studyTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyTasks,
    aliasName: 'study_plans__id__study_tasks__study_plan_id',
  );

  $$StudyTasksTableProcessedTableManager get studyTasksRefs {
    final manager = $$StudyTasksTableTableManager(
      $_db,
      $_db.studyTasks,
    ).filter((f) => f.studyPlanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyTasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RevisionSchedulesTable, List<RevisionScheduleRow>>
  _revisionSchedulesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.revisionSchedules,
        aliasName: 'study_plans__id__revision_schedules__study_plan_id',
      );

  $$RevisionSchedulesTableProcessedTableManager get revisionSchedulesRefs {
    final manager = $$RevisionSchedulesTableTableManager(
      $_db,
      $_db.revisionSchedules,
    ).filter((f) => f.studyPlanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _revisionSchedulesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlannerRunsTable, List<PlannerRunRow>>
  _plannerRunsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.plannerRuns,
    aliasName: 'study_plans__id__planner_runs__study_plan_id',
  );

  $$PlannerRunsTableProcessedTableManager get plannerRunsRefs {
    final manager = $$PlannerRunsTableTableManager(
      $_db,
      $_db.plannerRuns,
    ).filter((f) => f.studyPlanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_plannerRunsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudyPlansTableFilterComposer
    extends Composer<_$AppDatabase, $StudyPlansTable> {
  $$StudyPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planType => $composableBuilder(
    column: $table.planType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetEndDate => $composableBuilder(
    column: $table.targetEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryExamId => $composableBuilder(
    column: $table.primaryExamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planningMode => $composableBuilder(
    column: $table.planningMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dailyIntensity => $composableBuilder(
    column: $table.dailyIntensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxDailyMinutes => $composableBuilder(
    column: $table.maxDailyMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxSessionMinutes => $composableBuilder(
    column: $table.maxSessionMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get planningBufferPercent => $composableBuilder(
    column: $table.planningBufferPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revisionBufferDays => $composableBuilder(
    column: $table.revisionBufferDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> subjectsRefs(
    Expression<bool> Function($$SubjectsTableFilterComposer f) f,
  ) {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> examsRefs(
    Expression<bool> Function($$ExamsTableFilterComposer f) f,
  ) {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableFilterComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weeklyAvailabilitiesRefs(
    Expression<bool> Function($$WeeklyAvailabilitiesTableFilterComposer f) f,
  ) {
    final $$WeeklyAvailabilitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weeklyAvailabilities,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyAvailabilitiesTableFilterComposer(
            $db: $db,
            $table: $db.weeklyAvailabilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> calendarExceptionsRefs(
    Expression<bool> Function($$CalendarExceptionsTableFilterComposer f) f,
  ) {
    final $$CalendarExceptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.calendarExceptions,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CalendarExceptionsTableFilterComposer(
            $db: $db,
            $table: $db.calendarExceptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studyTasksRefs(
    Expression<bool> Function($$StudyTasksTableFilterComposer f) f,
  ) {
    final $$StudyTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableFilterComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> revisionSchedulesRefs(
    Expression<bool> Function($$RevisionSchedulesTableFilterComposer f) f,
  ) {
    final $$RevisionSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.revisionSchedules,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RevisionSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.revisionSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> plannerRunsRefs(
    Expression<bool> Function($$PlannerRunsTableFilterComposer f) f,
  ) {
    final $$PlannerRunsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannerRuns,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannerRunsTableFilterComposer(
            $db: $db,
            $table: $db.plannerRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyPlansTable> {
  $$StudyPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planType => $composableBuilder(
    column: $table.planType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetEndDate => $composableBuilder(
    column: $table.targetEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryExamId => $composableBuilder(
    column: $table.primaryExamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planningMode => $composableBuilder(
    column: $table.planningMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dailyIntensity => $composableBuilder(
    column: $table.dailyIntensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxDailyMinutes => $composableBuilder(
    column: $table.maxDailyMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxSessionMinutes => $composableBuilder(
    column: $table.maxSessionMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get planningBufferPercent => $composableBuilder(
    column: $table.planningBufferPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revisionBufferDays => $composableBuilder(
    column: $table.revisionBufferDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyPlansTable> {
  $$StudyPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get planType =>
      $composableBuilder(column: $table.planType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get targetEndDate => $composableBuilder(
    column: $table.targetEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryExamId => $composableBuilder(
    column: $table.primaryExamId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get planningMode => $composableBuilder(
    column: $table.planningMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dailyIntensity => $composableBuilder(
    column: $table.dailyIntensity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxDailyMinutes => $composableBuilder(
    column: $table.maxDailyMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxSessionMinutes => $composableBuilder(
    column: $table.maxSessionMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get planningBufferPercent => $composableBuilder(
    column: $table.planningBufferPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revisionBufferDays => $composableBuilder(
    column: $table.revisionBufferDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  Expression<T> subjectsRefs<T extends Object>(
    Expression<T> Function($$SubjectsTableAnnotationComposer a) f,
  ) {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> examsRefs<T extends Object>(
    Expression<T> Function($$ExamsTableAnnotationComposer a) f,
  ) {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableAnnotationComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> weeklyAvailabilitiesRefs<T extends Object>(
    Expression<T> Function($$WeeklyAvailabilitiesTableAnnotationComposer a) f,
  ) {
    final $$WeeklyAvailabilitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.weeklyAvailabilities,
          getReferencedColumn: (t) => t.studyPlanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WeeklyAvailabilitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.weeklyAvailabilities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> calendarExceptionsRefs<T extends Object>(
    Expression<T> Function($$CalendarExceptionsTableAnnotationComposer a) f,
  ) {
    final $$CalendarExceptionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.calendarExceptions,
          getReferencedColumn: (t) => t.studyPlanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CalendarExceptionsTableAnnotationComposer(
                $db: $db,
                $table: $db.calendarExceptions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> studyTasksRefs<T extends Object>(
    Expression<T> Function($$StudyTasksTableAnnotationComposer a) f,
  ) {
    final $$StudyTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> revisionSchedulesRefs<T extends Object>(
    Expression<T> Function($$RevisionSchedulesTableAnnotationComposer a) f,
  ) {
    final $$RevisionSchedulesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.revisionSchedules,
          getReferencedColumn: (t) => t.studyPlanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RevisionSchedulesTableAnnotationComposer(
                $db: $db,
                $table: $db.revisionSchedules,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> plannerRunsRefs<T extends Object>(
    Expression<T> Function($$PlannerRunsTableAnnotationComposer a) f,
  ) {
    final $$PlannerRunsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plannerRuns,
      getReferencedColumn: (t) => t.studyPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlannerRunsTableAnnotationComposer(
            $db: $db,
            $table: $db.plannerRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyPlansTable,
          StudyPlanRow,
          $$StudyPlansTableFilterComposer,
          $$StudyPlansTableOrderingComposer,
          $$StudyPlansTableAnnotationComposer,
          $$StudyPlansTableCreateCompanionBuilder,
          $$StudyPlansTableUpdateCompanionBuilder,
          (StudyPlanRow, $$StudyPlansTableReferences),
          StudyPlanRow,
          PrefetchHooks Function({
            bool subjectsRefs,
            bool examsRefs,
            bool weeklyAvailabilitiesRefs,
            bool calendarExceptionsRefs,
            bool studyTasksRefs,
            bool revisionSchedulesRefs,
            bool plannerRunsRefs,
          })
        > {
  $$StudyPlansTableTableManager(_$AppDatabase db, $StudyPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> planType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> targetEndDate = const Value.absent(),
                Value<String?> primaryExamId = const Value.absent(),
                Value<String> planningMode = const Value.absent(),
                Value<String> dailyIntensity = const Value.absent(),
                Value<int> maxDailyMinutes = const Value.absent(),
                Value<int> maxSessionMinutes = const Value.absent(),
                Value<int> planningBufferPercent = const Value.absent(),
                Value<int> revisionBufferDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyPlansCompanion(
                id: id,
                name: name,
                description: description,
                planType: planType,
                status: status,
                startDate: startDate,
                targetEndDate: targetEndDate,
                primaryExamId: primaryExamId,
                planningMode: planningMode,
                dailyIntensity: dailyIntensity,
                maxDailyMinutes: maxDailyMinutes,
                maxSessionMinutes: maxSessionMinutes,
                planningBufferPercent: planningBufferPercent,
                revisionBufferDays: revisionBufferDays,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                required String planType,
                required String status,
                required DateTime startDate,
                Value<DateTime?> targetEndDate = const Value.absent(),
                Value<String?> primaryExamId = const Value.absent(),
                required String planningMode,
                required String dailyIntensity,
                required int maxDailyMinutes,
                required int maxSessionMinutes,
                required int planningBufferPercent,
                required int revisionBufferDays,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyPlansCompanion.insert(
                id: id,
                name: name,
                description: description,
                planType: planType,
                status: status,
                startDate: startDate,
                targetEndDate: targetEndDate,
                primaryExamId: primaryExamId,
                planningMode: planningMode,
                dailyIntensity: dailyIntensity,
                maxDailyMinutes: maxDailyMinutes,
                maxSessionMinutes: maxSessionMinutes,
                planningBufferPercent: planningBufferPercent,
                revisionBufferDays: revisionBufferDays,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudyPlansTable, StudyPlanRow>(table),
                  $$StudyPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectsRefs = false,
                examsRefs = false,
                weeklyAvailabilitiesRefs = false,
                calendarExceptionsRefs = false,
                studyTasksRefs = false,
                revisionSchedulesRefs = false,
                plannerRunsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (subjectsRefs) db.subjects,
                    if (examsRefs) db.exams,
                    if (weeklyAvailabilitiesRefs) db.weeklyAvailabilities,
                    if (calendarExceptionsRefs) db.calendarExceptions,
                    if (studyTasksRefs) db.studyTasks,
                    if (revisionSchedulesRefs) db.revisionSchedules,
                    if (plannerRunsRefs) db.plannerRuns,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (subjectsRefs)
                        await $_getPrefetchedData<
                          StudyPlanRow,
                          $StudyPlansTable,
                          SubjectRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudyPlansTableReferences
                              ._subjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).subjectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyPlanId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (examsRefs)
                        await $_getPrefetchedData<
                          StudyPlanRow,
                          $StudyPlansTable,
                          ExamRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudyPlansTableReferences
                              ._examsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).examsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyPlanId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (weeklyAvailabilitiesRefs)
                        await $_getPrefetchedData<
                          StudyPlanRow,
                          $StudyPlansTable,
                          WeeklyAvailabilityRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudyPlansTableReferences
                              ._weeklyAvailabilitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).weeklyAvailabilitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyPlanId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (calendarExceptionsRefs)
                        await $_getPrefetchedData<
                          StudyPlanRow,
                          $StudyPlansTable,
                          CalendarExceptionRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudyPlansTableReferences
                              ._calendarExceptionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).calendarExceptionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyPlanId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studyTasksRefs)
                        await $_getPrefetchedData<
                          StudyPlanRow,
                          $StudyPlansTable,
                          StudyTaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudyPlansTableReferences
                              ._studyTasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).studyTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyPlanId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (revisionSchedulesRefs)
                        await $_getPrefetchedData<
                          StudyPlanRow,
                          $StudyPlansTable,
                          RevisionScheduleRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudyPlansTableReferences
                              ._revisionSchedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).revisionSchedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyPlanId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (plannerRunsRefs)
                        await $_getPrefetchedData<
                          StudyPlanRow,
                          $StudyPlansTable,
                          PlannerRunRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudyPlansTableReferences
                              ._plannerRunsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).plannerRunsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyPlanId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StudyPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyPlansTable,
      StudyPlanRow,
      $$StudyPlansTableFilterComposer,
      $$StudyPlansTableOrderingComposer,
      $$StudyPlansTableAnnotationComposer,
      $$StudyPlansTableCreateCompanionBuilder,
      $$StudyPlansTableUpdateCompanionBuilder,
      (StudyPlanRow, $$StudyPlansTableReferences),
      StudyPlanRow,
      PrefetchHooks Function({
        bool subjectsRefs,
        bool examsRefs,
        bool weeklyAvailabilitiesRefs,
        bool calendarExceptionsRefs,
        bool studyTasksRefs,
        bool revisionSchedulesRefs,
        bool plannerRunsRefs,
      })
    >;
typedef $$SubjectsTableCreateCompanionBuilder = SubjectsCompanion Function({
  required String id,
  required String studyPlanId,
  required String name,
  Value<String?> code,
  Value<String?> paperName,
  required String colorToken,
  required String iconToken,
  required String priority,
  required String difficulty,
  required String confidence,
  required String status,
  required int sortOrder,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SubjectsTableUpdateCompanionBuilder = SubjectsCompanion Function({
  Value<String> id,
  Value<String> studyPlanId,
  Value<String> name,
  Value<String?> code,
  Value<String?> paperName,
  Value<String> colorToken,
  Value<String> iconToken,
  Value<String> priority,
  Value<String> difficulty,
  Value<String> confidence,
  Value<String> status,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$SubjectsTableReferences
    extends BaseReferences<_$AppDatabase, $SubjectsTable, SubjectRow> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudyPlansTable _studyPlanIdTable(_$AppDatabase db) =>
      db.studyPlans.createAlias('subjects__study_plan_id__study_plans__id');

  $$StudyPlansTableProcessedTableManager get studyPlanId {
    final $_column = $_itemColumn<String>('study_plan_id')!;

    final manager = $$StudyPlansTableTableManager(
      $_db,
      $_db.studyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ChaptersTable, List<ChapterRow>>
  _chaptersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.chapters,
    aliasName: 'subjects__id__chapters__subject_id',
  );

  $$ChaptersTableProcessedTableManager get chaptersRefs {
    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chaptersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExamSyllabusItemsTable, List<ExamSyllabusItemRow>>
  _examSyllabusItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.examSyllabusItems,
        aliasName: 'subjects__id__exam_syllabus_items__subject_id',
      );

  $$ExamSyllabusItemsTableProcessedTableManager get examSyllabusItemsRefs {
    final manager = $$ExamSyllabusItemsTableTableManager(
      $_db,
      $_db.examSyllabusItems,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _examSyllabusItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudyTasksTable, List<StudyTaskRow>>
  _studyTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyTasks,
    aliasName: 'subjects__id__study_tasks__subject_id',
  );

  $$StudyTasksTableProcessedTableManager get studyTasksRefs {
    final manager = $$StudyTasksTableTableManager(
      $_db,
      $_db.studyTasks,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyTasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySessionRow>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'subjects__id__study_sessions__subject_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paperName => $composableBuilder(
    column: $table.paperName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconToken => $composableBuilder(
    column: $table.iconToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyPlansTableFilterComposer get studyPlanId {
    final $$StudyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableFilterComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> chaptersRefs(
    Expression<bool> Function($$ChaptersTableFilterComposer f) f,
  ) {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> examSyllabusItemsRefs(
    Expression<bool> Function($$ExamSyllabusItemsTableFilterComposer f) f,
  ) {
    final $$ExamSyllabusItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examSyllabusItems,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamSyllabusItemsTableFilterComposer(
            $db: $db,
            $table: $db.examSyllabusItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studyTasksRefs(
    Expression<bool> Function($$StudyTasksTableFilterComposer f) f,
  ) {
    final $$StudyTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableFilterComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paperName => $composableBuilder(
    column: $table.paperName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconToken => $composableBuilder(
    column: $table.iconToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyPlansTableOrderingComposer get studyPlanId {
    final $$StudyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get paperName =>
      $composableBuilder(column: $table.paperName, builder: (column) => column);

  GeneratedColumn<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconToken =>
      $composableBuilder(column: $table.iconToken, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$StudyPlansTableAnnotationComposer get studyPlanId {
    final $$StudyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> chaptersRefs<T extends Object>(
    Expression<T> Function($$ChaptersTableAnnotationComposer a) f,
  ) {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> examSyllabusItemsRefs<T extends Object>(
    Expression<T> Function($$ExamSyllabusItemsTableAnnotationComposer a) f,
  ) {
    final $$ExamSyllabusItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.examSyllabusItems,
          getReferencedColumn: (t) => t.subjectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExamSyllabusItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.examSyllabusItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> studyTasksRefs<T extends Object>(
    Expression<T> Function($$StudyTasksTableAnnotationComposer a) f,
  ) {
    final $$StudyTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          SubjectRow,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (SubjectRow, $$SubjectsTableReferences),
          SubjectRow,
          PrefetchHooks Function({
            bool studyPlanId,
            bool chaptersRefs,
            bool examSyllabusItemsRefs,
            bool studyTasksRefs,
            bool studySessionsRefs,
          })
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> studyPlanId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> code = const Value.absent(),
                Value<String?> paperName = const Value.absent(),
                Value<String> colorToken = const Value.absent(),
                Value<String> iconToken = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> confidence = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubjectsCompanion(
                id: id,
                studyPlanId: studyPlanId,
                name: name,
                code: code,
                paperName: paperName,
                colorToken: colorToken,
                iconToken: iconToken,
                priority: priority,
                difficulty: difficulty,
                confidence: confidence,
                status: status,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String studyPlanId,
                required String name,
                Value<String?> code = const Value.absent(),
                Value<String?> paperName = const Value.absent(),
                required String colorToken,
                required String iconToken,
                required String priority,
                required String difficulty,
                required String confidence,
                required String status,
                required int sortOrder,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SubjectsCompanion.insert(
                id: id,
                studyPlanId: studyPlanId,
                name: name,
                code: code,
                paperName: paperName,
                colorToken: colorToken,
                iconToken: iconToken,
                priority: priority,
                difficulty: difficulty,
                confidence: confidence,
                status: status,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SubjectsTable, SubjectRow>(table),
                  $$SubjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studyPlanId = false,
                chaptersRefs = false,
                examSyllabusItemsRefs = false,
                studyTasksRefs = false,
                studySessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (chaptersRefs) db.chapters,
                    if (examSyllabusItemsRefs) db.examSyllabusItems,
                    if (studyTasksRefs) db.studyTasks,
                    if (studySessionsRefs) db.studySessions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studyPlanId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.studyPlanId,
                            referencedTable: $$SubjectsTableReferences
                                ._studyPlanIdTable(db),
                            referencedColumn: $$SubjectsTableReferences
                                ._studyPlanIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (chaptersRefs)
                        await $_getPrefetchedData<
                          SubjectRow,
                          $SubjectsTable,
                          ChapterRow
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._chaptersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).chaptersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (examSyllabusItemsRefs)
                        await $_getPrefetchedData<
                          SubjectRow,
                          $SubjectsTable,
                          ExamSyllabusItemRow
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._examSyllabusItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).examSyllabusItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studyTasksRefs)
                        await $_getPrefetchedData<
                          SubjectRow,
                          $SubjectsTable,
                          StudyTaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._studyTasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).studyTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studySessionsRefs)
                        await $_getPrefetchedData<
                          SubjectRow,
                          $SubjectsTable,
                          StudySessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._studySessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      SubjectRow,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (SubjectRow, $$SubjectsTableReferences),
      SubjectRow,
      PrefetchHooks Function({
        bool studyPlanId,
        bool chaptersRefs,
        bool examSyllabusItemsRefs,
        bool studyTasksRefs,
        bool studySessionsRefs,
      })
    >;
typedef $$ChaptersTableCreateCompanionBuilder = ChaptersCompanion Function({
  required String id,
  required String subjectId,
  required String title,
  Value<int?> chapterNumber,
  required int estimatedMinutes,
  required int completedMinutes,
  required String difficulty,
  required String confidence,
  required String priority,
  required String examImportance,
  required String status,
  Value<String?> notes,
  required int sortOrder,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$ChaptersTableUpdateCompanionBuilder = ChaptersCompanion Function({
  Value<String> id,
  Value<String> subjectId,
  Value<String> title,
  Value<int?> chapterNumber,
  Value<int> estimatedMinutes,
  Value<int> completedMinutes,
  Value<String> difficulty,
  Value<String> confidence,
  Value<String> priority,
  Value<String> examImportance,
  Value<String> status,
  Value<String?> notes,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

final class $$ChaptersTableReferences
    extends BaseReferences<_$AppDatabase, $ChaptersTable, ChapterRow> {
  $$ChaptersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('chapters__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExamSyllabusItemsTable, List<ExamSyllabusItemRow>>
  _examSyllabusItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.examSyllabusItems,
        aliasName: 'chapters__id__exam_syllabus_items__chapter_id',
      );

  $$ExamSyllabusItemsTableProcessedTableManager get examSyllabusItemsRefs {
    final manager = $$ExamSyllabusItemsTableTableManager(
      $_db,
      $_db.examSyllabusItems,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _examSyllabusItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudyTasksTable, List<StudyTaskRow>>
  _studyTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyTasks,
    aliasName: 'chapters__id__study_tasks__chapter_id',
  );

  $$StudyTasksTableProcessedTableManager get studyTasksRefs {
    final manager = $$StudyTasksTableTableManager(
      $_db,
      $_db.studyTasks,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyTasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySessionRow>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'chapters__id__study_sessions__chapter_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RevisionSchedulesTable, List<RevisionScheduleRow>>
  _revisionSchedulesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.revisionSchedules,
        aliasName: 'chapters__id__revision_schedules__chapter_id',
      );

  $$RevisionSchedulesTableProcessedTableManager get revisionSchedulesRefs {
    final manager = $$RevisionSchedulesTableTableManager(
      $_db,
      $_db.revisionSchedules,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _revisionSchedulesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChaptersTableFilterComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapterNumber => $composableBuilder(
    column: $table.chapterNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examImportance => $composableBuilder(
    column: $table.examImportance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> examSyllabusItemsRefs(
    Expression<bool> Function($$ExamSyllabusItemsTableFilterComposer f) f,
  ) {
    final $$ExamSyllabusItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examSyllabusItems,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamSyllabusItemsTableFilterComposer(
            $db: $db,
            $table: $db.examSyllabusItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studyTasksRefs(
    Expression<bool> Function($$StudyTasksTableFilterComposer f) f,
  ) {
    final $$StudyTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableFilterComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> revisionSchedulesRefs(
    Expression<bool> Function($$RevisionSchedulesTableFilterComposer f) f,
  ) {
    final $$RevisionSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.revisionSchedules,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RevisionSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.revisionSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableOrderingComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapterNumber => $composableBuilder(
    column: $table.chapterNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examImportance => $composableBuilder(
    column: $table.examImportance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChaptersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get chapterNumber => $composableBuilder(
    column: $table.chapterNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get examImportance => $composableBuilder(
    column: $table.examImportance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> examSyllabusItemsRefs<T extends Object>(
    Expression<T> Function($$ExamSyllabusItemsTableAnnotationComposer a) f,
  ) {
    final $$ExamSyllabusItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.examSyllabusItems,
          getReferencedColumn: (t) => t.chapterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExamSyllabusItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.examSyllabusItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> studyTasksRefs<T extends Object>(
    Expression<T> Function($$StudyTasksTableAnnotationComposer a) f,
  ) {
    final $$StudyTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> revisionSchedulesRefs<T extends Object>(
    Expression<T> Function($$RevisionSchedulesTableAnnotationComposer a) f,
  ) {
    final $$RevisionSchedulesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.revisionSchedules,
          getReferencedColumn: (t) => t.chapterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RevisionSchedulesTableAnnotationComposer(
                $db: $db,
                $table: $db.revisionSchedules,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ChaptersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChaptersTable,
          ChapterRow,
          $$ChaptersTableFilterComposer,
          $$ChaptersTableOrderingComposer,
          $$ChaptersTableAnnotationComposer,
          $$ChaptersTableCreateCompanionBuilder,
          $$ChaptersTableUpdateCompanionBuilder,
          (ChapterRow, $$ChaptersTableReferences),
          ChapterRow,
          PrefetchHooks Function({
            bool subjectId,
            bool examSyllabusItemsRefs,
            bool studyTasksRefs,
            bool studySessionsRefs,
            bool revisionSchedulesRefs,
          })
        > {
  $$ChaptersTableTableManager(_$AppDatabase db, $ChaptersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int?> chapterNumber = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<int> completedMinutes = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> confidence = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> examImportance = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChaptersCompanion(
                id: id,
                subjectId: subjectId,
                title: title,
                chapterNumber: chapterNumber,
                estimatedMinutes: estimatedMinutes,
                completedMinutes: completedMinutes,
                difficulty: difficulty,
                confidence: confidence,
                priority: priority,
                examImportance: examImportance,
                status: status,
                notes: notes,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subjectId,
                required String title,
                Value<int?> chapterNumber = const Value.absent(),
                required int estimatedMinutes,
                required int completedMinutes,
                required String difficulty,
                required String confidence,
                required String priority,
                required String examImportance,
                required String status,
                Value<String?> notes = const Value.absent(),
                required int sortOrder,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChaptersCompanion.insert(
                id: id,
                subjectId: subjectId,
                title: title,
                chapterNumber: chapterNumber,
                estimatedMinutes: estimatedMinutes,
                completedMinutes: completedMinutes,
                difficulty: difficulty,
                confidence: confidence,
                priority: priority,
                examImportance: examImportance,
                status: status,
                notes: notes,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ChaptersTable, ChapterRow>(table),
                  $$ChaptersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectId = false,
                examSyllabusItemsRefs = false,
                studyTasksRefs = false,
                studySessionsRefs = false,
                revisionSchedulesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (examSyllabusItemsRefs) db.examSyllabusItems,
                    if (studyTasksRefs) db.studyTasks,
                    if (studySessionsRefs) db.studySessions,
                    if (revisionSchedulesRefs) db.revisionSchedules,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$ChaptersTableReferences
                                ._subjectIdTable(db),
                            referencedColumn: $$ChaptersTableReferences
                                ._subjectIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (examSyllabusItemsRefs)
                        await $_getPrefetchedData<
                          ChapterRow,
                          $ChaptersTable,
                          ExamSyllabusItemRow
                        >(
                          currentTable: table,
                          referencedTable: $$ChaptersTableReferences
                              ._examSyllabusItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChaptersTableReferences(
                                db,
                                table,
                                p0,
                              ).examSyllabusItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chapterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studyTasksRefs)
                        await $_getPrefetchedData<
                          ChapterRow,
                          $ChaptersTable,
                          StudyTaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$ChaptersTableReferences
                              ._studyTasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChaptersTableReferences(
                                db,
                                table,
                                p0,
                              ).studyTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chapterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studySessionsRefs)
                        await $_getPrefetchedData<
                          ChapterRow,
                          $ChaptersTable,
                          StudySessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$ChaptersTableReferences
                              ._studySessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChaptersTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chapterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (revisionSchedulesRefs)
                        await $_getPrefetchedData<
                          ChapterRow,
                          $ChaptersTable,
                          RevisionScheduleRow
                        >(
                          currentTable: table,
                          referencedTable: $$ChaptersTableReferences
                              ._revisionSchedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChaptersTableReferences(
                                db,
                                table,
                                p0,
                              ).revisionSchedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chapterId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ChaptersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChaptersTable,
      ChapterRow,
      $$ChaptersTableFilterComposer,
      $$ChaptersTableOrderingComposer,
      $$ChaptersTableAnnotationComposer,
      $$ChaptersTableCreateCompanionBuilder,
      $$ChaptersTableUpdateCompanionBuilder,
      (ChapterRow, $$ChaptersTableReferences),
      ChapterRow,
      PrefetchHooks Function({
        bool subjectId,
        bool examSyllabusItemsRefs,
        bool studyTasksRefs,
        bool studySessionsRefs,
        bool revisionSchedulesRefs,
      })
    >;
typedef $$ExamsTableCreateCompanionBuilder = ExamsCompanion Function({
  required String id,
  required String studyPlanId,
  required String name,
  required String examType,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<int?> timeOfDay,
  required String importance,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ExamsTableUpdateCompanionBuilder = ExamsCompanion Function({
  Value<String> id,
  Value<String> studyPlanId,
  Value<String> name,
  Value<String> examType,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<int?> timeOfDay,
  Value<String> importance,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$ExamsTableReferences
    extends BaseReferences<_$AppDatabase, $ExamsTable, ExamRow> {
  $$ExamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudyPlansTable _studyPlanIdTable(_$AppDatabase db) =>
      db.studyPlans.createAlias('exams__study_plan_id__study_plans__id');

  $$StudyPlansTableProcessedTableManager get studyPlanId {
    final $_column = $_itemColumn<String>('study_plan_id')!;

    final manager = $$StudyPlansTableTableManager(
      $_db,
      $_db.studyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExamSyllabusItemsTable, List<ExamSyllabusItemRow>>
  _examSyllabusItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.examSyllabusItems,
        aliasName: 'exams__id__exam_syllabus_items__exam_id',
      );

  $$ExamSyllabusItemsTableProcessedTableManager get examSyllabusItemsRefs {
    final manager = $$ExamSyllabusItemsTableTableManager(
      $_db,
      $_db.examSyllabusItems,
    ).filter((f) => f.examId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _examSyllabusItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudyTasksTable, List<StudyTaskRow>>
  _studyTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyTasks,
    aliasName: 'exams__id__study_tasks__exam_id',
  );

  $$StudyTasksTableProcessedTableManager get studyTasksRefs {
    final manager = $$StudyTasksTableTableManager(
      $_db,
      $_db.studyTasks,
    ).filter((f) => f.examId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyTasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExamsTableFilterComposer extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examType => $composableBuilder(
    column: $table.examType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyPlansTableFilterComposer get studyPlanId {
    final $$StudyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableFilterComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> examSyllabusItemsRefs(
    Expression<bool> Function($$ExamSyllabusItemsTableFilterComposer f) f,
  ) {
    final $$ExamSyllabusItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examSyllabusItems,
      getReferencedColumn: (t) => t.examId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamSyllabusItemsTableFilterComposer(
            $db: $db,
            $table: $db.examSyllabusItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studyTasksRefs(
    Expression<bool> Function($$StudyTasksTableFilterComposer f) f,
  ) {
    final $$StudyTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.examId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableFilterComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExamsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examType => $composableBuilder(
    column: $table.examType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyPlansTableOrderingComposer get studyPlanId {
    final $$StudyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get examType =>
      $composableBuilder(column: $table.examType, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<String> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$StudyPlansTableAnnotationComposer get studyPlanId {
    final $$StudyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> examSyllabusItemsRefs<T extends Object>(
    Expression<T> Function($$ExamSyllabusItemsTableAnnotationComposer a) f,
  ) {
    final $$ExamSyllabusItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.examSyllabusItems,
          getReferencedColumn: (t) => t.examId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExamSyllabusItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.examSyllabusItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> studyTasksRefs<T extends Object>(
    Expression<T> Function($$StudyTasksTableAnnotationComposer a) f,
  ) {
    final $$StudyTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.examId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamsTable,
          ExamRow,
          $$ExamsTableFilterComposer,
          $$ExamsTableOrderingComposer,
          $$ExamsTableAnnotationComposer,
          $$ExamsTableCreateCompanionBuilder,
          $$ExamsTableUpdateCompanionBuilder,
          (ExamRow, $$ExamsTableReferences),
          ExamRow,
          PrefetchHooks Function({
            bool studyPlanId,
            bool examSyllabusItemsRefs,
            bool studyTasksRefs,
          })
        > {
  $$ExamsTableTableManager(_$AppDatabase db, $ExamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> studyPlanId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> examType = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int?> timeOfDay = const Value.absent(),
                Value<String> importance = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamsCompanion(
                id: id,
                studyPlanId: studyPlanId,
                name: name,
                examType: examType,
                startDate: startDate,
                endDate: endDate,
                timeOfDay: timeOfDay,
                importance: importance,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String studyPlanId,
                required String name,
                required String examType,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<int?> timeOfDay = const Value.absent(),
                required String importance,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ExamsCompanion.insert(
                id: id,
                studyPlanId: studyPlanId,
                name: name,
                examType: examType,
                startDate: startDate,
                endDate: endDate,
                timeOfDay: timeOfDay,
                importance: importance,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExamsTable, ExamRow>(table),
                  $$ExamsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studyPlanId = false,
                examSyllabusItemsRefs = false,
                studyTasksRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (examSyllabusItemsRefs) db.examSyllabusItems,
                    if (studyTasksRefs) db.studyTasks,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studyPlanId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.studyPlanId,
                            referencedTable: $$ExamsTableReferences
                                ._studyPlanIdTable(db),
                            referencedColumn: $$ExamsTableReferences
                                ._studyPlanIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (examSyllabusItemsRefs)
                        await $_getPrefetchedData<
                          ExamRow,
                          $ExamsTable,
                          ExamSyllabusItemRow
                        >(
                          currentTable: table,
                          referencedTable: $$ExamsTableReferences
                              ._examSyllabusItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExamsTableReferences(
                                db,
                                table,
                                p0,
                              ).examSyllabusItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.examId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studyTasksRefs)
                        await $_getPrefetchedData<
                          ExamRow,
                          $ExamsTable,
                          StudyTaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$ExamsTableReferences
                              ._studyTasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExamsTableReferences(
                                db,
                                table,
                                p0,
                              ).studyTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.examId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamsTable,
      ExamRow,
      $$ExamsTableFilterComposer,
      $$ExamsTableOrderingComposer,
      $$ExamsTableAnnotationComposer,
      $$ExamsTableCreateCompanionBuilder,
      $$ExamsTableUpdateCompanionBuilder,
      (ExamRow, $$ExamsTableReferences),
      ExamRow,
      PrefetchHooks Function({
        bool studyPlanId,
        bool examSyllabusItemsRefs,
        bool studyTasksRefs,
      })
    >;
typedef $$ExamSyllabusItemsTableCreateCompanionBuilder =
    ExamSyllabusItemsCompanion Function({
      required String id,
      required String examId,
      required String subjectId,
      Value<String?> chapterId,
      Value<String?> topicId,
      required int weight,
      required bool isRequired,
      Value<int> rowid,
    });
typedef $$ExamSyllabusItemsTableUpdateCompanionBuilder =
    ExamSyllabusItemsCompanion Function({
      Value<String> id,
      Value<String> examId,
      Value<String> subjectId,
      Value<String?> chapterId,
      Value<String?> topicId,
      Value<int> weight,
      Value<bool> isRequired,
      Value<int> rowid,
    });

final class $$ExamSyllabusItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExamSyllabusItemsTable,
          ExamSyllabusItemRow
        > {
  $$ExamSyllabusItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExamsTable _examIdTable(_$AppDatabase db) =>
      db.exams.createAlias('exam_syllabus_items__exam_id__exams__id');

  $$ExamsTableProcessedTableManager get examId {
    final $_column = $_itemColumn<String>('exam_id')!;

    final manager = $$ExamsTableTableManager(
      $_db,
      $_db.exams,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('exam_syllabus_items__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias('exam_syllabus_items__chapter_id__chapters__id');

  $$ChaptersTableProcessedTableManager? get chapterId {
    final $_column = $_itemColumn<String>('chapter_id');
    if ($_column == null) return null;
    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExamSyllabusItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ExamSyllabusItemsTable> {
  $$ExamSyllabusItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnFilters(column),
  );

  $$ExamsTableFilterComposer get examId {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.examId,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableFilterComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamSyllabusItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamSyllabusItemsTable> {
  $$ExamSyllabusItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExamsTableOrderingComposer get examId {
    final $$ExamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.examId,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableOrderingComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamSyllabusItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamSyllabusItemsTable> {
  $$ExamSyllabusItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => column,
  );

  $$ExamsTableAnnotationComposer get examId {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.examId,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableAnnotationComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamSyllabusItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamSyllabusItemsTable,
          ExamSyllabusItemRow,
          $$ExamSyllabusItemsTableFilterComposer,
          $$ExamSyllabusItemsTableOrderingComposer,
          $$ExamSyllabusItemsTableAnnotationComposer,
          $$ExamSyllabusItemsTableCreateCompanionBuilder,
          $$ExamSyllabusItemsTableUpdateCompanionBuilder,
          (ExamSyllabusItemRow, $$ExamSyllabusItemsTableReferences),
          ExamSyllabusItemRow,
          PrefetchHooks Function({bool examId, bool subjectId, bool chapterId})
        > {
  $$ExamSyllabusItemsTableTableManager(
    _$AppDatabase db,
    $ExamSyllabusItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamSyllabusItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamSyllabusItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamSyllabusItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> examId = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String?> chapterId = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<int> weight = const Value.absent(),
                Value<bool> isRequired = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamSyllabusItemsCompanion(
                id: id,
                examId: examId,
                subjectId: subjectId,
                chapterId: chapterId,
                topicId: topicId,
                weight: weight,
                isRequired: isRequired,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String examId,
                required String subjectId,
                Value<String?> chapterId = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                required int weight,
                required bool isRequired,
                Value<int> rowid = const Value.absent(),
              }) => ExamSyllabusItemsCompanion.insert(
                id: id,
                examId: examId,
                subjectId: subjectId,
                chapterId: chapterId,
                topicId: topicId,
                weight: weight,
                isRequired: isRequired,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExamSyllabusItemsTable, ExamSyllabusItemRow>(
                    table,
                  ),
                  $$ExamSyllabusItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({examId = false, subjectId = false, chapterId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (examId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.examId,
                            referencedTable: $$ExamSyllabusItemsTableReferences
                                ._examIdTable(db),
                            referencedColumn: $$ExamSyllabusItemsTableReferences
                                ._examIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$ExamSyllabusItemsTableReferences
                                ._subjectIdTable(db),
                            referencedColumn: $$ExamSyllabusItemsTableReferences
                                ._subjectIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (chapterId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$ExamSyllabusItemsTableReferences
                                ._chapterIdTable(db),
                            referencedColumn: $$ExamSyllabusItemsTableReferences
                                ._chapterIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ExamSyllabusItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamSyllabusItemsTable,
      ExamSyllabusItemRow,
      $$ExamSyllabusItemsTableFilterComposer,
      $$ExamSyllabusItemsTableOrderingComposer,
      $$ExamSyllabusItemsTableAnnotationComposer,
      $$ExamSyllabusItemsTableCreateCompanionBuilder,
      $$ExamSyllabusItemsTableUpdateCompanionBuilder,
      (ExamSyllabusItemRow, $$ExamSyllabusItemsTableReferences),
      ExamSyllabusItemRow,
      PrefetchHooks Function({bool examId, bool subjectId, bool chapterId})
    >;
typedef $$WeeklyAvailabilitiesTableCreateCompanionBuilder =
    WeeklyAvailabilitiesCompanion Function({
      required String id,
      required String studyPlanId,
      required int weekday,
      required int totalAvailableMinutes,
      required bool isStudyDay,
      Value<int?> preferredStartTime,
      Value<int?> preferredEndTime,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WeeklyAvailabilitiesTableUpdateCompanionBuilder =
    WeeklyAvailabilitiesCompanion Function({
      Value<String> id,
      Value<String> studyPlanId,
      Value<int> weekday,
      Value<int> totalAvailableMinutes,
      Value<bool> isStudyDay,
      Value<int?> preferredStartTime,
      Value<int?> preferredEndTime,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$WeeklyAvailabilitiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WeeklyAvailabilitiesTable,
          WeeklyAvailabilityRow
        > {
  $$WeeklyAvailabilitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudyPlansTable _studyPlanIdTable(_$AppDatabase db) => db.studyPlans
      .createAlias('weekly_availability__study_plan_id__study_plans__id');

  $$StudyPlansTableProcessedTableManager get studyPlanId {
    final $_column = $_itemColumn<String>('study_plan_id')!;

    final manager = $$StudyPlansTableTableManager(
      $_db,
      $_db.studyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeeklyAvailabilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyAvailabilitiesTable> {
  $$WeeklyAvailabilitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAvailableMinutes => $composableBuilder(
    column: $table.totalAvailableMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStudyDay => $composableBuilder(
    column: $table.isStudyDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get preferredStartTime => $composableBuilder(
    column: $table.preferredStartTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get preferredEndTime => $composableBuilder(
    column: $table.preferredEndTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyPlansTableFilterComposer get studyPlanId {
    final $$StudyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableFilterComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyAvailabilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyAvailabilitiesTable> {
  $$WeeklyAvailabilitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAvailableMinutes => $composableBuilder(
    column: $table.totalAvailableMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStudyDay => $composableBuilder(
    column: $table.isStudyDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get preferredStartTime => $composableBuilder(
    column: $table.preferredStartTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get preferredEndTime => $composableBuilder(
    column: $table.preferredEndTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyPlansTableOrderingComposer get studyPlanId {
    final $$StudyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyAvailabilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyAvailabilitiesTable> {
  $$WeeklyAvailabilitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weekday =>
      $composableBuilder(column: $table.weekday, builder: (column) => column);

  GeneratedColumn<int> get totalAvailableMinutes => $composableBuilder(
    column: $table.totalAvailableMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isStudyDay => $composableBuilder(
    column: $table.isStudyDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get preferredStartTime => $composableBuilder(
    column: $table.preferredStartTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get preferredEndTime => $composableBuilder(
    column: $table.preferredEndTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$StudyPlansTableAnnotationComposer get studyPlanId {
    final $$StudyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyAvailabilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklyAvailabilitiesTable,
          WeeklyAvailabilityRow,
          $$WeeklyAvailabilitiesTableFilterComposer,
          $$WeeklyAvailabilitiesTableOrderingComposer,
          $$WeeklyAvailabilitiesTableAnnotationComposer,
          $$WeeklyAvailabilitiesTableCreateCompanionBuilder,
          $$WeeklyAvailabilitiesTableUpdateCompanionBuilder,
          (WeeklyAvailabilityRow, $$WeeklyAvailabilitiesTableReferences),
          WeeklyAvailabilityRow,
          PrefetchHooks Function({bool studyPlanId})
        > {
  $$WeeklyAvailabilitiesTableTableManager(
    _$AppDatabase db,
    $WeeklyAvailabilitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyAvailabilitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyAvailabilitiesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WeeklyAvailabilitiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> studyPlanId = const Value.absent(),
                Value<int> weekday = const Value.absent(),
                Value<int> totalAvailableMinutes = const Value.absent(),
                Value<bool> isStudyDay = const Value.absent(),
                Value<int?> preferredStartTime = const Value.absent(),
                Value<int?> preferredEndTime = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyAvailabilitiesCompanion(
                id: id,
                studyPlanId: studyPlanId,
                weekday: weekday,
                totalAvailableMinutes: totalAvailableMinutes,
                isStudyDay: isStudyDay,
                preferredStartTime: preferredStartTime,
                preferredEndTime: preferredEndTime,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String studyPlanId,
                required int weekday,
                required int totalAvailableMinutes,
                required bool isStudyDay,
                Value<int?> preferredStartTime = const Value.absent(),
                Value<int?> preferredEndTime = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WeeklyAvailabilitiesCompanion.insert(
                id: id,
                studyPlanId: studyPlanId,
                weekday: weekday,
                totalAvailableMinutes: totalAvailableMinutes,
                isStudyDay: isStudyDay,
                preferredStartTime: preferredStartTime,
                preferredEndTime: preferredEndTime,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $WeeklyAvailabilitiesTable,
                    WeeklyAvailabilityRow
                  >(table),
                  $$WeeklyAvailabilitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studyPlanId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (studyPlanId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studyPlanId,
                        referencedTable: $$WeeklyAvailabilitiesTableReferences
                            ._studyPlanIdTable(db),
                        referencedColumn: $$WeeklyAvailabilitiesTableReferences
                            ._studyPlanIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeeklyAvailabilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklyAvailabilitiesTable,
      WeeklyAvailabilityRow,
      $$WeeklyAvailabilitiesTableFilterComposer,
      $$WeeklyAvailabilitiesTableOrderingComposer,
      $$WeeklyAvailabilitiesTableAnnotationComposer,
      $$WeeklyAvailabilitiesTableCreateCompanionBuilder,
      $$WeeklyAvailabilitiesTableUpdateCompanionBuilder,
      (WeeklyAvailabilityRow, $$WeeklyAvailabilitiesTableReferences),
      WeeklyAvailabilityRow,
      PrefetchHooks Function({bool studyPlanId})
    >;
typedef $$CalendarExceptionsTableCreateCompanionBuilder =
    CalendarExceptionsCompanion Function({
      required String id,
      required String studyPlanId,
      required DateTime exceptionDate,
      required String exceptionType,
      Value<int?> availableMinutesOverride,
      Value<String?> reason,
      required bool isNoStudyDay,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CalendarExceptionsTableUpdateCompanionBuilder =
    CalendarExceptionsCompanion Function({
      Value<String> id,
      Value<String> studyPlanId,
      Value<DateTime> exceptionDate,
      Value<String> exceptionType,
      Value<int?> availableMinutesOverride,
      Value<String?> reason,
      Value<bool> isNoStudyDay,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$CalendarExceptionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CalendarExceptionsTable,
          CalendarExceptionRow
        > {
  $$CalendarExceptionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudyPlansTable _studyPlanIdTable(_$AppDatabase db) => db.studyPlans
      .createAlias('calendar_exceptions__study_plan_id__study_plans__id');

  $$StudyPlansTableProcessedTableManager get studyPlanId {
    final $_column = $_itemColumn<String>('study_plan_id')!;

    final manager = $$StudyPlansTableTableManager(
      $_db,
      $_db.studyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CalendarExceptionsTableFilterComposer
    extends Composer<_$AppDatabase, $CalendarExceptionsTable> {
  $$CalendarExceptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get exceptionDate => $composableBuilder(
    column: $table.exceptionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exceptionType => $composableBuilder(
    column: $table.exceptionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get availableMinutesOverride => $composableBuilder(
    column: $table.availableMinutesOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNoStudyDay => $composableBuilder(
    column: $table.isNoStudyDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyPlansTableFilterComposer get studyPlanId {
    final $$StudyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableFilterComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CalendarExceptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CalendarExceptionsTable> {
  $$CalendarExceptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get exceptionDate => $composableBuilder(
    column: $table.exceptionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exceptionType => $composableBuilder(
    column: $table.exceptionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get availableMinutesOverride => $composableBuilder(
    column: $table.availableMinutesOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNoStudyDay => $composableBuilder(
    column: $table.isNoStudyDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyPlansTableOrderingComposer get studyPlanId {
    final $$StudyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CalendarExceptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalendarExceptionsTable> {
  $$CalendarExceptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get exceptionDate => $composableBuilder(
    column: $table.exceptionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exceptionType => $composableBuilder(
    column: $table.exceptionType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get availableMinutesOverride => $composableBuilder(
    column: $table.availableMinutesOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<bool> get isNoStudyDay => $composableBuilder(
    column: $table.isNoStudyDay,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StudyPlansTableAnnotationComposer get studyPlanId {
    final $$StudyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CalendarExceptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalendarExceptionsTable,
          CalendarExceptionRow,
          $$CalendarExceptionsTableFilterComposer,
          $$CalendarExceptionsTableOrderingComposer,
          $$CalendarExceptionsTableAnnotationComposer,
          $$CalendarExceptionsTableCreateCompanionBuilder,
          $$CalendarExceptionsTableUpdateCompanionBuilder,
          (CalendarExceptionRow, $$CalendarExceptionsTableReferences),
          CalendarExceptionRow,
          PrefetchHooks Function({bool studyPlanId})
        > {
  $$CalendarExceptionsTableTableManager(
    _$AppDatabase db,
    $CalendarExceptionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalendarExceptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalendarExceptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalendarExceptionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> studyPlanId = const Value.absent(),
                Value<DateTime> exceptionDate = const Value.absent(),
                Value<String> exceptionType = const Value.absent(),
                Value<int?> availableMinutesOverride = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<bool> isNoStudyDay = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalendarExceptionsCompanion(
                id: id,
                studyPlanId: studyPlanId,
                exceptionDate: exceptionDate,
                exceptionType: exceptionType,
                availableMinutesOverride: availableMinutesOverride,
                reason: reason,
                isNoStudyDay: isNoStudyDay,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String studyPlanId,
                required DateTime exceptionDate,
                required String exceptionType,
                Value<int?> availableMinutesOverride = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                required bool isNoStudyDay,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CalendarExceptionsCompanion.insert(
                id: id,
                studyPlanId: studyPlanId,
                exceptionDate: exceptionDate,
                exceptionType: exceptionType,
                availableMinutesOverride: availableMinutesOverride,
                reason: reason,
                isNoStudyDay: isNoStudyDay,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CalendarExceptionsTable, CalendarExceptionRow>(
                    table,
                  ),
                  $$CalendarExceptionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studyPlanId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (studyPlanId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studyPlanId,
                        referencedTable: $$CalendarExceptionsTableReferences
                            ._studyPlanIdTable(db),
                        referencedColumn: $$CalendarExceptionsTableReferences
                            ._studyPlanIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CalendarExceptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalendarExceptionsTable,
      CalendarExceptionRow,
      $$CalendarExceptionsTableFilterComposer,
      $$CalendarExceptionsTableOrderingComposer,
      $$CalendarExceptionsTableAnnotationComposer,
      $$CalendarExceptionsTableCreateCompanionBuilder,
      $$CalendarExceptionsTableUpdateCompanionBuilder,
      (CalendarExceptionRow, $$CalendarExceptionsTableReferences),
      CalendarExceptionRow,
      PrefetchHooks Function({bool studyPlanId})
    >;
typedef $$StudyTasksTableCreateCompanionBuilder = StudyTasksCompanion Function({
  required String id,
  required String studyPlanId,
  required String subjectId,
  Value<String?> chapterId,
  Value<String?> topicId,
  Value<String?> examId,
  required String taskType,
  required String title,
  required DateTime plannedDate,
  Value<int?> plannedStartTime,
  required int plannedMinutes,
  Value<int?> actualMinutes,
  required int priorityScore,
  required bool isLocked,
  required String status,
  required int completionPercent,
  required String source,
  Value<String?> generationBatchId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$StudyTasksTableUpdateCompanionBuilder = StudyTasksCompanion Function({
  Value<String> id,
  Value<String> studyPlanId,
  Value<String> subjectId,
  Value<String?> chapterId,
  Value<String?> topicId,
  Value<String?> examId,
  Value<String> taskType,
  Value<String> title,
  Value<DateTime> plannedDate,
  Value<int?> plannedStartTime,
  Value<int> plannedMinutes,
  Value<int?> actualMinutes,
  Value<int> priorityScore,
  Value<bool> isLocked,
  Value<String> status,
  Value<int> completionPercent,
  Value<String> source,
  Value<String?> generationBatchId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

final class $$StudyTasksTableReferences
    extends BaseReferences<_$AppDatabase, $StudyTasksTable, StudyTaskRow> {
  $$StudyTasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudyPlansTable _studyPlanIdTable(_$AppDatabase db) =>
      db.studyPlans.createAlias('study_tasks__study_plan_id__study_plans__id');

  $$StudyPlansTableProcessedTableManager get studyPlanId {
    final $_column = $_itemColumn<String>('study_plan_id')!;

    final manager = $$StudyPlansTableTableManager(
      $_db,
      $_db.studyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('study_tasks__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias('study_tasks__chapter_id__chapters__id');

  $$ChaptersTableProcessedTableManager? get chapterId {
    final $_column = $_itemColumn<String>('chapter_id');
    if ($_column == null) return null;
    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExamsTable _examIdTable(_$AppDatabase db) =>
      db.exams.createAlias('study_tasks__exam_id__exams__id');

  $$ExamsTableProcessedTableManager? get examId {
    final $_column = $_itemColumn<String>('exam_id');
    if ($_column == null) return null;
    final manager = $$ExamsTableTableManager(
      $_db,
      $_db.exams,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySessionRow>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'study_tasks__id__study_sessions__study_task_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.studyTaskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudyTasksTableFilterComposer
    extends Composer<_$AppDatabase, $StudyTasksTable> {
  $$StudyTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskType => $composableBuilder(
    column: $table.taskType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get plannedDate => $composableBuilder(
    column: $table.plannedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedStartTime => $composableBuilder(
    column: $table.plannedStartTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualMinutes => $composableBuilder(
    column: $table.actualMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priorityScore => $composableBuilder(
    column: $table.priorityScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLocked => $composableBuilder(
    column: $table.isLocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completionPercent => $composableBuilder(
    column: $table.completionPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get generationBatchId => $composableBuilder(
    column: $table.generationBatchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyPlansTableFilterComposer get studyPlanId {
    final $$StudyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableFilterComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExamsTableFilterComposer get examId {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.examId,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableFilterComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.studyTaskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyTasksTable> {
  $$StudyTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskType => $composableBuilder(
    column: $table.taskType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get plannedDate => $composableBuilder(
    column: $table.plannedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedStartTime => $composableBuilder(
    column: $table.plannedStartTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualMinutes => $composableBuilder(
    column: $table.actualMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priorityScore => $composableBuilder(
    column: $table.priorityScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLocked => $composableBuilder(
    column: $table.isLocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completionPercent => $composableBuilder(
    column: $table.completionPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get generationBatchId => $composableBuilder(
    column: $table.generationBatchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyPlansTableOrderingComposer get studyPlanId {
    final $$StudyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExamsTableOrderingComposer get examId {
    final $$ExamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.examId,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableOrderingComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudyTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyTasksTable> {
  $$StudyTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<String> get taskType =>
      $composableBuilder(column: $table.taskType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get plannedDate => $composableBuilder(
    column: $table.plannedDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plannedStartTime => $composableBuilder(
    column: $table.plannedStartTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualMinutes => $composableBuilder(
    column: $table.actualMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priorityScore => $composableBuilder(
    column: $table.priorityScore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isLocked =>
      $composableBuilder(column: $table.isLocked, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get completionPercent => $composableBuilder(
    column: $table.completionPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get generationBatchId => $composableBuilder(
    column: $table.generationBatchId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$StudyPlansTableAnnotationComposer get studyPlanId {
    final $$StudyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExamsTableAnnotationComposer get examId {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.examId,
      referencedTable: $db.exams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamsTableAnnotationComposer(
            $db: $db,
            $table: $db.exams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.studyTaskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyTasksTable,
          StudyTaskRow,
          $$StudyTasksTableFilterComposer,
          $$StudyTasksTableOrderingComposer,
          $$StudyTasksTableAnnotationComposer,
          $$StudyTasksTableCreateCompanionBuilder,
          $$StudyTasksTableUpdateCompanionBuilder,
          (StudyTaskRow, $$StudyTasksTableReferences),
          StudyTaskRow,
          PrefetchHooks Function({
            bool studyPlanId,
            bool subjectId,
            bool chapterId,
            bool examId,
            bool studySessionsRefs,
          })
        > {
  $$StudyTasksTableTableManager(_$AppDatabase db, $StudyTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> studyPlanId = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String?> chapterId = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<String?> examId = const Value.absent(),
                Value<String> taskType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> plannedDate = const Value.absent(),
                Value<int?> plannedStartTime = const Value.absent(),
                Value<int> plannedMinutes = const Value.absent(),
                Value<int?> actualMinutes = const Value.absent(),
                Value<int> priorityScore = const Value.absent(),
                Value<bool> isLocked = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> completionPercent = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> generationBatchId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyTasksCompanion(
                id: id,
                studyPlanId: studyPlanId,
                subjectId: subjectId,
                chapterId: chapterId,
                topicId: topicId,
                examId: examId,
                taskType: taskType,
                title: title,
                plannedDate: plannedDate,
                plannedStartTime: plannedStartTime,
                plannedMinutes: plannedMinutes,
                actualMinutes: actualMinutes,
                priorityScore: priorityScore,
                isLocked: isLocked,
                status: status,
                completionPercent: completionPercent,
                source: source,
                generationBatchId: generationBatchId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String studyPlanId,
                required String subjectId,
                Value<String?> chapterId = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<String?> examId = const Value.absent(),
                required String taskType,
                required String title,
                required DateTime plannedDate,
                Value<int?> plannedStartTime = const Value.absent(),
                required int plannedMinutes,
                Value<int?> actualMinutes = const Value.absent(),
                required int priorityScore,
                required bool isLocked,
                required String status,
                required int completionPercent,
                required String source,
                Value<String?> generationBatchId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyTasksCompanion.insert(
                id: id,
                studyPlanId: studyPlanId,
                subjectId: subjectId,
                chapterId: chapterId,
                topicId: topicId,
                examId: examId,
                taskType: taskType,
                title: title,
                plannedDate: plannedDate,
                plannedStartTime: plannedStartTime,
                plannedMinutes: plannedMinutes,
                actualMinutes: actualMinutes,
                priorityScore: priorityScore,
                isLocked: isLocked,
                status: status,
                completionPercent: completionPercent,
                source: source,
                generationBatchId: generationBatchId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudyTasksTable, StudyTaskRow>(table),
                  $$StudyTasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studyPlanId = false,
                subjectId = false,
                chapterId = false,
                examId = false,
                studySessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studySessionsRefs) db.studySessions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studyPlanId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.studyPlanId,
                            referencedTable: $$StudyTasksTableReferences
                                ._studyPlanIdTable(db),
                            referencedColumn: $$StudyTasksTableReferences
                                ._studyPlanIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$StudyTasksTableReferences
                                ._subjectIdTable(db),
                            referencedColumn: $$StudyTasksTableReferences
                                ._subjectIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (chapterId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$StudyTasksTableReferences
                                ._chapterIdTable(db),
                            referencedColumn: $$StudyTasksTableReferences
                                ._chapterIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (examId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.examId,
                            referencedTable: $$StudyTasksTableReferences
                                ._examIdTable(db),
                            referencedColumn: $$StudyTasksTableReferences
                                ._examIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studySessionsRefs)
                        await $_getPrefetchedData<
                          StudyTaskRow,
                          $StudyTasksTable,
                          StudySessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudyTasksTableReferences
                              ._studySessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyTasksTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studyTaskId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StudyTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyTasksTable,
      StudyTaskRow,
      $$StudyTasksTableFilterComposer,
      $$StudyTasksTableOrderingComposer,
      $$StudyTasksTableAnnotationComposer,
      $$StudyTasksTableCreateCompanionBuilder,
      $$StudyTasksTableUpdateCompanionBuilder,
      (StudyTaskRow, $$StudyTasksTableReferences),
      StudyTaskRow,
      PrefetchHooks Function({
        bool studyPlanId,
        bool subjectId,
        bool chapterId,
        bool examId,
        bool studySessionsRefs,
      })
    >;
typedef $$StudySessionsTableCreateCompanionBuilder =
    StudySessionsCompanion Function({
      required String id,
      Value<String?> studyTaskId,
      required String subjectId,
      Value<String?> chapterId,
      Value<String?> topicId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      required int plannedMinutes,
      required int actualMinutes,
      required int completionPercent,
      required String result,
      Value<String?> confidenceBefore,
      Value<String?> confidenceAfter,
      Value<String?> note,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$StudySessionsTableUpdateCompanionBuilder =
    StudySessionsCompanion Function({
      Value<String> id,
      Value<String?> studyTaskId,
      Value<String> subjectId,
      Value<String?> chapterId,
      Value<String?> topicId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> plannedMinutes,
      Value<int> actualMinutes,
      Value<int> completionPercent,
      Value<String> result,
      Value<String?> confidenceBefore,
      Value<String?> confidenceAfter,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$StudySessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $StudySessionsTable, StudySessionRow> {
  $$StudySessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudyTasksTable _studyTaskIdTable(_$AppDatabase db) => db.studyTasks
      .createAlias('study_sessions__study_task_id__study_tasks__id');

  $$StudyTasksTableProcessedTableManager? get studyTaskId {
    final $_column = $_itemColumn<String>('study_task_id');
    if ($_column == null) return null;
    final manager = $$StudyTasksTableTableManager(
      $_db,
      $_db.studyTasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyTaskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('study_sessions__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias('study_sessions__chapter_id__chapters__id');

  $$ChaptersTableProcessedTableManager? get chapterId {
    final $_column = $_itemColumn<String>('chapter_id');
    if ($_column == null) return null;
    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RevisionSchedulesTable, List<RevisionScheduleRow>>
  _revisionSchedulesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.revisionSchedules,
        aliasName:
            'study_sessions__id__revision_schedules__source_study_session_id',
      );

  $$RevisionSchedulesTableProcessedTableManager get revisionSchedulesRefs {
    final manager =
        $$RevisionSchedulesTableTableManager(
          $_db,
          $_db.revisionSchedules,
        ).filter(
          (f) =>
              f.sourceStudySessionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _revisionSchedulesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudySessionsTableFilterComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualMinutes => $composableBuilder(
    column: $table.actualMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completionPercent => $composableBuilder(
    column: $table.completionPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confidenceBefore => $composableBuilder(
    column: $table.confidenceBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confidenceAfter => $composableBuilder(
    column: $table.confidenceAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyTasksTableFilterComposer get studyTaskId {
    final $$StudyTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyTaskId,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableFilterComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> revisionSchedulesRefs(
    Expression<bool> Function($$RevisionSchedulesTableFilterComposer f) f,
  ) {
    final $$RevisionSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.revisionSchedules,
      getReferencedColumn: (t) => t.sourceStudySessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RevisionSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.revisionSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudySessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualMinutes => $composableBuilder(
    column: $table.actualMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completionPercent => $composableBuilder(
    column: $table.completionPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confidenceBefore => $composableBuilder(
    column: $table.confidenceBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confidenceAfter => $composableBuilder(
    column: $table.confidenceAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyTasksTableOrderingComposer get studyTaskId {
    final $$StudyTasksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyTaskId,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableOrderingComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualMinutes => $composableBuilder(
    column: $table.actualMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completionPercent => $composableBuilder(
    column: $table.completionPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<String> get confidenceBefore => $composableBuilder(
    column: $table.confidenceBefore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get confidenceAfter => $composableBuilder(
    column: $table.confidenceAfter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StudyTasksTableAnnotationComposer get studyTaskId {
    final $$StudyTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyTaskId,
      referencedTable: $db.studyTasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.studyTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> revisionSchedulesRefs<T extends Object>(
    Expression<T> Function($$RevisionSchedulesTableAnnotationComposer a) f,
  ) {
    final $$RevisionSchedulesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.revisionSchedules,
          getReferencedColumn: (t) => t.sourceStudySessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RevisionSchedulesTableAnnotationComposer(
                $db: $db,
                $table: $db.revisionSchedules,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$StudySessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudySessionsTable,
          StudySessionRow,
          $$StudySessionsTableFilterComposer,
          $$StudySessionsTableOrderingComposer,
          $$StudySessionsTableAnnotationComposer,
          $$StudySessionsTableCreateCompanionBuilder,
          $$StudySessionsTableUpdateCompanionBuilder,
          (StudySessionRow, $$StudySessionsTableReferences),
          StudySessionRow,
          PrefetchHooks Function({
            bool studyTaskId,
            bool subjectId,
            bool chapterId,
            bool revisionSchedulesRefs,
          })
        > {
  $$StudySessionsTableTableManager(_$AppDatabase db, $StudySessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudySessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudySessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudySessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> studyTaskId = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String?> chapterId = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> plannedMinutes = const Value.absent(),
                Value<int> actualMinutes = const Value.absent(),
                Value<int> completionPercent = const Value.absent(),
                Value<String> result = const Value.absent(),
                Value<String?> confidenceBefore = const Value.absent(),
                Value<String?> confidenceAfter = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion(
                id: id,
                studyTaskId: studyTaskId,
                subjectId: subjectId,
                chapterId: chapterId,
                topicId: topicId,
                startedAt: startedAt,
                endedAt: endedAt,
                plannedMinutes: plannedMinutes,
                actualMinutes: actualMinutes,
                completionPercent: completionPercent,
                result: result,
                confidenceBefore: confidenceBefore,
                confidenceAfter: confidenceAfter,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> studyTaskId = const Value.absent(),
                required String subjectId,
                Value<String?> chapterId = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                required int plannedMinutes,
                required int actualMinutes,
                required int completionPercent,
                required String result,
                Value<String?> confidenceBefore = const Value.absent(),
                Value<String?> confidenceAfter = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => StudySessionsCompanion.insert(
                id: id,
                studyTaskId: studyTaskId,
                subjectId: subjectId,
                chapterId: chapterId,
                topicId: topicId,
                startedAt: startedAt,
                endedAt: endedAt,
                plannedMinutes: plannedMinutes,
                actualMinutes: actualMinutes,
                completionPercent: completionPercent,
                result: result,
                confidenceBefore: confidenceBefore,
                confidenceAfter: confidenceAfter,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudySessionsTable, StudySessionRow>(table),
                  $$StudySessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studyTaskId = false,
                subjectId = false,
                chapterId = false,
                revisionSchedulesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (revisionSchedulesRefs) db.revisionSchedules,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studyTaskId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.studyTaskId,
                            referencedTable: $$StudySessionsTableReferences
                                ._studyTaskIdTable(db),
                            referencedColumn: $$StudySessionsTableReferences
                                ._studyTaskIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$StudySessionsTableReferences
                                ._subjectIdTable(db),
                            referencedColumn: $$StudySessionsTableReferences
                                ._subjectIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (chapterId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$StudySessionsTableReferences
                                ._chapterIdTable(db),
                            referencedColumn: $$StudySessionsTableReferences
                                ._chapterIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (revisionSchedulesRefs)
                        await $_getPrefetchedData<
                          StudySessionRow,
                          $StudySessionsTable,
                          RevisionScheduleRow
                        >(
                          currentTable: table,
                          referencedTable: $$StudySessionsTableReferences
                              ._revisionSchedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudySessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).revisionSchedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceStudySessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StudySessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudySessionsTable,
      StudySessionRow,
      $$StudySessionsTableFilterComposer,
      $$StudySessionsTableOrderingComposer,
      $$StudySessionsTableAnnotationComposer,
      $$StudySessionsTableCreateCompanionBuilder,
      $$StudySessionsTableUpdateCompanionBuilder,
      (StudySessionRow, $$StudySessionsTableReferences),
      StudySessionRow,
      PrefetchHooks Function({
        bool studyTaskId,
        bool subjectId,
        bool chapterId,
        bool revisionSchedulesRefs,
      })
    >;
typedef $$RevisionSchedulesTableCreateCompanionBuilder =
    RevisionSchedulesCompanion Function({
      required String id,
      required String studyPlanId,
      required String chapterId,
      Value<String?> topicId,
      Value<String?> sourceStudySessionId,
      required int revisionNumber,
      required DateTime dueDate,
      required int estimatedMinutes,
      required String status,
      Value<DateTime?> completedAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$RevisionSchedulesTableUpdateCompanionBuilder =
    RevisionSchedulesCompanion Function({
      Value<String> id,
      Value<String> studyPlanId,
      Value<String> chapterId,
      Value<String?> topicId,
      Value<String?> sourceStudySessionId,
      Value<int> revisionNumber,
      Value<DateTime> dueDate,
      Value<int> estimatedMinutes,
      Value<String> status,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$RevisionSchedulesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RevisionSchedulesTable,
          RevisionScheduleRow
        > {
  $$RevisionSchedulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudyPlansTable _studyPlanIdTable(_$AppDatabase db) => db.studyPlans
      .createAlias('revision_schedules__study_plan_id__study_plans__id');

  $$StudyPlansTableProcessedTableManager get studyPlanId {
    final $_column = $_itemColumn<String>('study_plan_id')!;

    final manager = $$StudyPlansTableTableManager(
      $_db,
      $_db.studyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias('revision_schedules__chapter_id__chapters__id');

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<String>('chapter_id')!;

    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudySessionsTable _sourceStudySessionIdTable(_$AppDatabase db) =>
      db.studySessions.createAlias(
        'revision_schedules__source_study_session_id__study_sessions__id',
      );

  $$StudySessionsTableProcessedTableManager? get sourceStudySessionId {
    final $_column = $_itemColumn<String>('source_study_session_id');
    if ($_column == null) return null;
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _sourceStudySessionIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RevisionSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $RevisionSchedulesTable> {
  $$RevisionSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revisionNumber => $composableBuilder(
    column: $table.revisionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyPlansTableFilterComposer get studyPlanId {
    final $$StudyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableFilterComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudySessionsTableFilterComposer get sourceStudySessionId {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceStudySessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RevisionSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $RevisionSchedulesTable> {
  $$RevisionSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revisionNumber => $composableBuilder(
    column: $table.revisionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyPlansTableOrderingComposer get studyPlanId {
    final $$StudyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudySessionsTableOrderingComposer get sourceStudySessionId {
    final $$StudySessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceStudySessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableOrderingComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RevisionSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RevisionSchedulesTable> {
  $$RevisionSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<int> get revisionNumber => $composableBuilder(
    column: $table.revisionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StudyPlansTableAnnotationComposer get studyPlanId {
    final $$StudyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudySessionsTableAnnotationComposer get sourceStudySessionId {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceStudySessionId,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RevisionSchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RevisionSchedulesTable,
          RevisionScheduleRow,
          $$RevisionSchedulesTableFilterComposer,
          $$RevisionSchedulesTableOrderingComposer,
          $$RevisionSchedulesTableAnnotationComposer,
          $$RevisionSchedulesTableCreateCompanionBuilder,
          $$RevisionSchedulesTableUpdateCompanionBuilder,
          (RevisionScheduleRow, $$RevisionSchedulesTableReferences),
          RevisionScheduleRow,
          PrefetchHooks Function({
            bool studyPlanId,
            bool chapterId,
            bool sourceStudySessionId,
          })
        > {
  $$RevisionSchedulesTableTableManager(
    _$AppDatabase db,
    $RevisionSchedulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RevisionSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RevisionSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RevisionSchedulesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> studyPlanId = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<String?> sourceStudySessionId = const Value.absent(),
                Value<int> revisionNumber = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RevisionSchedulesCompanion(
                id: id,
                studyPlanId: studyPlanId,
                chapterId: chapterId,
                topicId: topicId,
                sourceStudySessionId: sourceStudySessionId,
                revisionNumber: revisionNumber,
                dueDate: dueDate,
                estimatedMinutes: estimatedMinutes,
                status: status,
                completedAt: completedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String studyPlanId,
                required String chapterId,
                Value<String?> topicId = const Value.absent(),
                Value<String?> sourceStudySessionId = const Value.absent(),
                required int revisionNumber,
                required DateTime dueDate,
                required int estimatedMinutes,
                required String status,
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RevisionSchedulesCompanion.insert(
                id: id,
                studyPlanId: studyPlanId,
                chapterId: chapterId,
                topicId: topicId,
                sourceStudySessionId: sourceStudySessionId,
                revisionNumber: revisionNumber,
                dueDate: dueDate,
                estimatedMinutes: estimatedMinutes,
                status: status,
                completedAt: completedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RevisionSchedulesTable, RevisionScheduleRow>(
                    table,
                  ),
                  $$RevisionSchedulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studyPlanId = false,
                chapterId = false,
                sourceStudySessionId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studyPlanId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.studyPlanId,
                            referencedTable: $$RevisionSchedulesTableReferences
                                ._studyPlanIdTable(db),
                            referencedColumn: $$RevisionSchedulesTableReferences
                                ._studyPlanIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (chapterId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$RevisionSchedulesTableReferences
                                ._chapterIdTable(db),
                            referencedColumn: $$RevisionSchedulesTableReferences
                                ._chapterIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (sourceStudySessionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.sourceStudySessionId,
                            referencedTable: $$RevisionSchedulesTableReferences
                                ._sourceStudySessionIdTable(db),
                            referencedColumn: $$RevisionSchedulesTableReferences
                                ._sourceStudySessionIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$RevisionSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RevisionSchedulesTable,
      RevisionScheduleRow,
      $$RevisionSchedulesTableFilterComposer,
      $$RevisionSchedulesTableOrderingComposer,
      $$RevisionSchedulesTableAnnotationComposer,
      $$RevisionSchedulesTableCreateCompanionBuilder,
      $$RevisionSchedulesTableUpdateCompanionBuilder,
      (RevisionScheduleRow, $$RevisionSchedulesTableReferences),
      RevisionScheduleRow,
      PrefetchHooks Function({
        bool studyPlanId,
        bool chapterId,
        bool sourceStudySessionId,
      })
    >;
typedef $$PlannerRunsTableCreateCompanionBuilder =
    PlannerRunsCompanion Function({
      required String id,
      required String studyPlanId,
      required String trigger,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      required int inputTaskCount,
      required int outputTaskCount,
      required String riskLevel,
      Value<DateTime?> expectedFinishDate,
      required String algorithmVersion,
      Value<int> rowid,
    });
typedef $$PlannerRunsTableUpdateCompanionBuilder =
    PlannerRunsCompanion Function({
      Value<String> id,
      Value<String> studyPlanId,
      Value<String> trigger,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<int> inputTaskCount,
      Value<int> outputTaskCount,
      Value<String> riskLevel,
      Value<DateTime?> expectedFinishDate,
      Value<String> algorithmVersion,
      Value<int> rowid,
    });

final class $$PlannerRunsTableReferences
    extends BaseReferences<_$AppDatabase, $PlannerRunsTable, PlannerRunRow> {
  $$PlannerRunsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudyPlansTable _studyPlanIdTable(_$AppDatabase db) =>
      db.studyPlans.createAlias('planner_runs__study_plan_id__study_plans__id');

  $$StudyPlansTableProcessedTableManager get studyPlanId {
    final $_column = $_itemColumn<String>('study_plan_id')!;

    final manager = $$StudyPlansTableTableManager(
      $_db,
      $_db.studyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studyPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlannerRunsTableFilterComposer
    extends Composer<_$AppDatabase, $PlannerRunsTable> {
  $$PlannerRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inputTaskCount => $composableBuilder(
    column: $table.inputTaskCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get outputTaskCount => $composableBuilder(
    column: $table.outputTaskCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riskLevel => $composableBuilder(
    column: $table.riskLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedFinishDate => $composableBuilder(
    column: $table.expectedFinishDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyPlansTableFilterComposer get studyPlanId {
    final $$StudyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableFilterComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlannerRunsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlannerRunsTable> {
  $$PlannerRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inputTaskCount => $composableBuilder(
    column: $table.inputTaskCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get outputTaskCount => $composableBuilder(
    column: $table.outputTaskCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riskLevel => $composableBuilder(
    column: $table.riskLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedFinishDate => $composableBuilder(
    column: $table.expectedFinishDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyPlansTableOrderingComposer get studyPlanId {
    final $$StudyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlannerRunsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlannerRunsTable> {
  $$PlannerRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get trigger =>
      $composableBuilder(column: $table.trigger, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inputTaskCount => $composableBuilder(
    column: $table.inputTaskCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get outputTaskCount => $composableBuilder(
    column: $table.outputTaskCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get riskLevel =>
      $composableBuilder(column: $table.riskLevel, builder: (column) => column);

  GeneratedColumn<DateTime> get expectedFinishDate => $composableBuilder(
    column: $table.expectedFinishDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => column,
  );

  $$StudyPlansTableAnnotationComposer get studyPlanId {
    final $$StudyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studyPlanId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlannerRunsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlannerRunsTable,
          PlannerRunRow,
          $$PlannerRunsTableFilterComposer,
          $$PlannerRunsTableOrderingComposer,
          $$PlannerRunsTableAnnotationComposer,
          $$PlannerRunsTableCreateCompanionBuilder,
          $$PlannerRunsTableUpdateCompanionBuilder,
          (PlannerRunRow, $$PlannerRunsTableReferences),
          PlannerRunRow,
          PrefetchHooks Function({bool studyPlanId})
        > {
  $$PlannerRunsTableTableManager(_$AppDatabase db, $PlannerRunsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlannerRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlannerRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlannerRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> studyPlanId = const Value.absent(),
                Value<String> trigger = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> inputTaskCount = const Value.absent(),
                Value<int> outputTaskCount = const Value.absent(),
                Value<String> riskLevel = const Value.absent(),
                Value<DateTime?> expectedFinishDate = const Value.absent(),
                Value<String> algorithmVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlannerRunsCompanion(
                id: id,
                studyPlanId: studyPlanId,
                trigger: trigger,
                startedAt: startedAt,
                completedAt: completedAt,
                inputTaskCount: inputTaskCount,
                outputTaskCount: outputTaskCount,
                riskLevel: riskLevel,
                expectedFinishDate: expectedFinishDate,
                algorithmVersion: algorithmVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String studyPlanId,
                required String trigger,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required int inputTaskCount,
                required int outputTaskCount,
                required String riskLevel,
                Value<DateTime?> expectedFinishDate = const Value.absent(),
                required String algorithmVersion,
                Value<int> rowid = const Value.absent(),
              }) => PlannerRunsCompanion.insert(
                id: id,
                studyPlanId: studyPlanId,
                trigger: trigger,
                startedAt: startedAt,
                completedAt: completedAt,
                inputTaskCount: inputTaskCount,
                outputTaskCount: outputTaskCount,
                riskLevel: riskLevel,
                expectedFinishDate: expectedFinishDate,
                algorithmVersion: algorithmVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlannerRunsTable, PlannerRunRow>(table),
                  $$PlannerRunsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({studyPlanId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (studyPlanId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.studyPlanId,
                        referencedTable: $$PlannerRunsTableReferences
                            ._studyPlanIdTable(db),
                        referencedColumn: $$PlannerRunsTableReferences
                            ._studyPlanIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlannerRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlannerRunsTable,
      PlannerRunRow,
      $$PlannerRunsTableFilterComposer,
      $$PlannerRunsTableOrderingComposer,
      $$PlannerRunsTableAnnotationComposer,
      $$PlannerRunsTableCreateCompanionBuilder,
      $$PlannerRunsTableUpdateCompanionBuilder,
      (PlannerRunRow, $$PlannerRunsTableReferences),
      PlannerRunRow,
      PrefetchHooks Function({bool studyPlanId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudentProfilesTableTableManager get studentProfiles =>
      $$StudentProfilesTableTableManager(_db, _db.studentProfiles);
  $$StudyPlansTableTableManager get studyPlans =>
      $$StudyPlansTableTableManager(_db, _db.studyPlans);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$ChaptersTableTableManager get chapters =>
      $$ChaptersTableTableManager(_db, _db.chapters);
  $$ExamsTableTableManager get exams =>
      $$ExamsTableTableManager(_db, _db.exams);
  $$ExamSyllabusItemsTableTableManager get examSyllabusItems =>
      $$ExamSyllabusItemsTableTableManager(_db, _db.examSyllabusItems);
  $$WeeklyAvailabilitiesTableTableManager get weeklyAvailabilities =>
      $$WeeklyAvailabilitiesTableTableManager(_db, _db.weeklyAvailabilities);
  $$CalendarExceptionsTableTableManager get calendarExceptions =>
      $$CalendarExceptionsTableTableManager(_db, _db.calendarExceptions);
  $$StudyTasksTableTableManager get studyTasks =>
      $$StudyTasksTableTableManager(_db, _db.studyTasks);
  $$StudySessionsTableTableManager get studySessions =>
      $$StudySessionsTableTableManager(_db, _db.studySessions);
  $$RevisionSchedulesTableTableManager get revisionSchedules =>
      $$RevisionSchedulesTableTableManager(_db, _db.revisionSchedules);
  $$PlannerRunsTableTableManager get plannerRuns =>
      $$PlannerRunsTableTableManager(_db, _db.plannerRuns);
}
