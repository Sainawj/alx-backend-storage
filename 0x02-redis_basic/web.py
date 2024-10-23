#!/usr/bin/env python3
'''A module with tools for request caching and tracking.
'''
import redis
import requests
from functools import wraps
from typing import Callable


redis_store = redis.Redis()
'''The module-level Redis instance.
'''


def data_cacher(method: Callable) -> Callable:
    '''Caches the output of fetched data.
    '''
    @wraps(method)
    def invoker(url) -> str:
        '''The wrapper function for caching the output.
        '''
        # Increment the request count for the URL in Redis
        redis_store.incr(f'count:{url}')
        # Check if the result is already cached
        result = redis_store.get(f'result:{url}')
        if result:
            # Return cached result if it exists
            return result.decode('utf-8')
        # Fetch the data using the original method
        result = method(url)
        # Reset the count for the URL in Redis
        redis_store.set(f'count:{url}', 0)
        # Cache the result with an expiration time of 10 seconds
        redis_store.setex(f'result:{url}', 10, result)
        return result
    return invoker


@data_cacher
def get_page(url: str) -> str:
    '''Returns the content of a URL after caching the request's response,
    and tracking the request.
    '''
    # Perform a GET request to the specified URL
    return requests.get(url).text