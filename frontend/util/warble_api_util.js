export const fetchWarbles = () => {
  return $.ajax({
    method: 'GET',
    url: 'api/warbles',
  });
};

export const fetchWarble = (id) => {
  // debugger
  return $.ajax({
    method: 'GET',
    url: `/api/warbles/${id}`,
  });
};

export const createWarble = warble => {
  // debugger
  return $.ajax({
    method: 'POST',
    url: 'api/warbles',
    data: {
      warble
    }
  });
};