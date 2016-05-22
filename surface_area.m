function area = surface_area(FV)

if ~isstruct(FV) || ~isfield(FV,'vertices') || ~isfield(FV,'faces')
    error('Not enough fields.');
end

vertexA = FV.vertices(FV.faces(:,1),:);
vertexB = FV.vertices(FV.faces(:,2),:);
vertexC = FV.vertices(FV.faces(:,3),:);

A = vertexA-vertexB;
B = vertexA-vertexC;
C = vertexB-vertexC;

EA = sqrt(A(:,1).^2+A(:,2).^2+A(:,3).^2);
EB = sqrt(B(:,1).^2+B(:,2).^2+B(:,3).^2);
EC = sqrt(C(:,1).^2+C(:,2).^2+C(:,3).^2);

p = (EA + EB + EC)/2;
Ar = sqrt(p.*(p-EA).*(p-EB).*(p-EC));
area = sum(Ar(:));

end