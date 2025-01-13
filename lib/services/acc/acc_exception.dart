class ACCException implements Exception {
  const ACCException();
}

class CategoryNameRequiredException extends ACCException {}

class CouldNotUploadCategoryException extends ACCException {}


