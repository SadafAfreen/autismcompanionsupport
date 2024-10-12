class ProfileStorageException implements Exception {
  const ProfileStorageException();
}

class CouldNotCreateProfileException extends ProfileStorageException {}

class CouldNotUpdateProfileException extends ProfileStorageException {}

class CouldNotGetProfileException extends ProfileStorageException {}

class CouldNotDeleteProfileException extends ProfileStorageException {}