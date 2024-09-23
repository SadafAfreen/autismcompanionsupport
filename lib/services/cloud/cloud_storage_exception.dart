class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateProfileException extends CloudStorageException {}

class CouldNotUpdateProfileException extends CloudStorageException {}

class CouldNotGetProfileException extends CloudStorageException {}

class CouldNotDeleteProfileException extends CloudStorageException {}