// ignore_for_file: file_names

class Person implements Comparable {
  final int id;
  final String firstName;
  final String lastName;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  String get fullName => '$firstName $lastName';

  Person.fromRow(Map<String, Object?> row)
      : id = row['ID'] as int,
        firstName = row['FIRST_NAME'] as String,
        lastName = row['LAST_NAME'] as String;

  @override
  int compareTo(covariant Person other) => id.compareTo(other.id);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Person, id = $id, firstName: $firstName, lastName: $lastName';
  }
}
