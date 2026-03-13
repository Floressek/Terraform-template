// Global Jest setup for server tests
// Mock typeorm-transactional to avoid requiring data sources/drivers in unit tests
jest.mock('typeorm-transactional', () => ({
  Transactional: () => (_target: any, _propertyKey: string, descriptor: PropertyDescriptor) => descriptor,
  initializeTransactionalContext: jest.fn(),
  addTransactionalDataSource: jest.fn(),
  StorageDriver: { ASYNC_LOCAL_STORAGE: 0 },
}));

// Optionally call initializeTransactionalContext if some tests import and expect it to be called
const { initializeTransactionalContext, StorageDriver } = require('typeorm-transactional');
if (initializeTransactionalContext) {
  try {
    initializeTransactionalContext({
      storageDriver: StorageDriver.ASYNC_LOCAL_STORAGE,
    });
  } catch (e) {
    // ignore in setup
  }
}
